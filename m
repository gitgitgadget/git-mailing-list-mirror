From: David Aguilar <davvid@gmail.com>
Subject: Re: A question about using 'add -p' to split the patch
Date: Mon, 15 Jun 2009 00:36:43 -0700
Message-ID: <20090615073635.GA53643@gmail.com>
References: <46dff0320906142008v4f278d3ek3eebfa36f7fcf06a@mail.gmail.com> <20090615061211.GA53136@gmail.com> <46dff0320906142324i191e50d5v1e89ba6311377a47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 09:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG6kV-00040L-57
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 09:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZFOHgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 03:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbZFOHgr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 03:36:47 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:45318 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbZFOHgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 03:36:46 -0400
Received: by pzk17 with SMTP id 17so1788031pzk.33
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=G6YT1YlM+ACD9uGBUNILaW6Xez4VY9mI13JgLfyT82g=;
        b=VvPdmQgIvCSfVzzpikD+HTbQnwDBc+WF0Vd9Mx8NAb3jTg4PwRp8lRx4hW1Ung5UeM
         uCLWdjiQwWcASpiKpbC1OwPEu1G2ETGGGZ1gN/C8zJpUlsVmEQH29XLWoo0hCaIQBRZo
         FMu19SYKI8Uad/fiBdm+3DsXVbhB/ORI/0aAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=N+EsNkkwEbEeLZA6NNG3/lFOS5IR7eGSTOylm0zJqSG9ND2JO3sRDQbjXw0OACmO44
         skf6KGQjM1IoSTWKQkRiDHNN2wHl8d75sbWz6c41gFC1fkLC04XyQN1OIful1smvMwhL
         Pzpg8Jv1M2nWChFegUjBbt1QVwa+02t9rKguw=
Received: by 10.142.193.10 with SMTP id q10mr2722688wff.274.1245051409138;
        Mon, 15 Jun 2009 00:36:49 -0700 (PDT)
Received: from gmail.com (cpe-76-171-7-203.socal.res.rr.com [76.171.7.203])
        by mx.google.com with ESMTPS id 29sm180938wfg.8.2009.06.15.00.36.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 00:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46dff0320906142324i191e50d5v1e89ba6311377a47@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121588>

On Mon, Jun 15, 2009 at 02:24:39PM +0800, Ping Yin wrote:
> On Mon, Jun 15, 2009 at 2:12 PM, David Aguilar<davvid@gmail.com> wrot=
e:
> > On Mon, Jun 15, 2009 at 11:08:51AM +0800, Ping Yin wrote:
> >> file bt.php in the HEAD:
> >>
> >> function bt_add($path) {
> >> =A0return;
> >> }
> >>
> >> file bt.php in the working directory:
> >>
> >> function bt_move($path, $pos) {
> >> =A0 return;
> >> }
> >> function bt_add($path, $pos) {
> >> =A0 bt_move($path, $pos)
> >> =A0 return;
> >> }
> >>
> >> Now i want to split the change into two parts:
> >> First introduce bt_move
> >> Then add a param pos to bt_add and call bt_move
> >>
> >> With the 'e' action of 'add -p', i got
> >>
> >> -function bt_add($path) {
> >> +function bt_move($path, $pos) {
> >> + =A0return;
> >> +}
> >> +function bt_add($path, $pos) {
> >> + =A0bt_move($path, $pos)
> >> =A0 =A0return;
> >> =A0}
> >>
> >> Then, i want to edit the patch to get
> >>
> >>
> >> function bt_move($path, $pos) {
> >> =A0 return;
> >> }
> >> function bt_add($path) {
> >> =A0 return;
> >> }
> >>
> >> However, whatever i do, the patch fails to apply. Any suggestion?
> >
> > Use git-gui or git-cola to select just bt_move() for addition.
> > You can stage specific lines.
>=20
> Doesn't the 'e' action of 'add -p' do the same job with git-gui?

It should.

I tried it in git-{cola,gui} and I was able to do it by first staging
the +bt_add(a,b) line, and then staging only the -bt_add(a) line.

=46or add -e I got it to work by editing the patch to;

+function bt_move($path, $pos) {
+ =A0return;
+}
 function bt_add($path) {
=A0 =A0return;
=A0}

The reason it's hard to get right is that you have to
reconstruct the context of the original content for the
adds/removes and remember to add the space before the
reconstructed bt_add($path).

Those kinda details are usually easier for software to get right
;-)

--=20
		David
