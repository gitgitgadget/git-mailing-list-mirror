From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-tred: Print the transitive reduction of the 
	dependecies
Date: Wed, 25 Mar 2009 12:20:53 +0100
Message-ID: <36ca99e90903250420l42a46718x91263b4adb7da45f@mail.gmail.com>
References: <1237977341-32173-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090325105841.GB27803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRBk-00080m-UR
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbZCYLU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 07:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZCYLU5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:20:57 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:64109 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZCYLU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 07:20:56 -0400
Received: by ewy9 with SMTP id 9so2475414ewy.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BSjdhgkrsPgxY6+sV3rIaLIhaDl3TVQvohBLkNRutl4=;
        b=gc3i96RSpWaIdFs/apoz0vi93iuM8Lwg9oyIt0YtU7tU1Z1073qnD0cxCpg7YgWJBc
         ovIzcrpqlxAuY2bTbViTQmkgnKZBSmYU9P8o5P1Nx8OhvIQBNEhXpkw92qlKwfB+yGo3
         U6EPwA0mQgtaS8Y0Dx29xW26vyWTQSHVjGRJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SGpeOHFIW/PUzAy+QbuU+bi87G6IwBCmq1IAofU6wri3XxtWdkis4jZEgFvtNgSCfn
         m6p3u2Rf9OXJOHGrevwe2bq+USfhUExHmZb8z7kC3VE354I5YDa1rtcVVhACnf7ufKis
         CIb0i/VNgJmuHm0MRQEA8sSIe4tTHYMic57xk=
Received: by 10.210.12.13 with SMTP id 13mr4068833ebl.1.1237980053722; Wed, 25 
	Mar 2009 04:20:53 -0700 (PDT)
In-Reply-To: <20090325105841.GB27803@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114586>

2009/3/25 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Wed, Mar 25, 2009 at 11:35:41AM +0100, Bert Wesarg wrote:
>> +$tg summary --graphviz |
>> + =C2=A0 =C2=A0 tred |
>> + =C2=A0 =C2=A0 gvpr -a "\"${name}\"" '
>> +BEG_G {
>> + =C2=A0 =C2=A0node_t =C2=A0ctr;
>> + =C2=A0 =C2=A0edge_t =C2=A0e;
>> +
>> + =C2=A0 =C2=A0ctr =3D isNode($, ARGV[0]);
>> + =C2=A0 =C2=A0for (e =3D fstedge(ctr); e; e =3D nxtedge(e,ctr)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e.head.name !=3D ARGV[0])
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("%s\n", e.head.nam=
e);
>> + =C2=A0 =C2=A0}
>> + =C2=A0 =C2=A0exit(0);
>> +}
> I don't know tred and gvpr, just looked shortly over the manpages.
> Anyhow what I consider important is that the order of .topdeps is
> stable. =C2=A0That is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t/topic1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t/topic2
>
> must not be rewritten to
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t/topic2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0t/topic1
>
> if master is redundant. =C2=A0Is this asserted?
I asked this myself, I haven't looked very deeply but I think it is
stable. And some tests showed this.

>
> And note that I intend to change the semantic of tg summary s.t. it o=
nly
> recurses on the current branch instead of all branches. =C2=A0I think=
 this
> doesn't hurt here, though.
I don't understand and can't confirm this. tg summary calls 'git
for-each-ref refs/top-bases' so all TopGit controlled branches should
be reached.

While I was adding a 'reduce' subcommand to tg-depend (which calls
tg-tred and updates .topdeps) I saw that it is immposible to add a
none TopGit controlled branch to the dependency list, which looks
wrong. Dependencies don't need to be TopGit controlled, like master.

Bert

>
> Best regards and thanks for your contribution,
> Uwe
