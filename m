From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 18:38:42 +0800
Message-ID: <41f08ee11003230338y5cf70a13xa649e67071bc2a72@mail.gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
	 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
	 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
	 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
	 <20100322081003.GA26535@progeny.tock>
	 <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
	 <m38w9jjqqd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 11:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu1Vd-0000xP-PT
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 11:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab0CWKio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 06:38:44 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:37660 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab0CWKin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 06:38:43 -0400
Received: by qyk9 with SMTP id 9so649035qyk.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W2rCGOB+ChO3VbC5CPiM5/HTK3EY4BXodEn71uMxQV0=;
        b=Gp/I61AYY21p+4aBmDgwUuwsxtzrYQoL+bxENG+1IcowQpsp+wguzwisabns2wPDsH
         D6G4nxhlq6DnRkTsdL3LmVxiv/o8qU1B0X5tfYrHBQO9IyICHkIfXzAtK39CJV3NU7e7
         ZfhX7/TtObRGC///Nt+4+xh1ySFsP9cEhDb2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CkzgMxD/XBV/Q+MR0TTwRjnlS8swi3ERrjgDmD6Ybb4DW34lt4MXQ/oRd6u/cKH9xh
         yqCncSPcmAsk0bfoMmtqYVQf7gTQpo6na//o4wJrxoBYn0JAF7NBIc5lAcdQQEgyR0rO
         XfrmoY9hFQxQdJTshXlyyRWI4Vy5ZcohAlWMs=
Received: by 10.229.221.14 with SMTP id ia14mr648368qcb.8.1269340722506; Tue, 
	23 Mar 2010 03:38:42 -0700 (PDT)
In-Reply-To: <m38w9jjqqd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143003>

Hi,

>
> Errr... how the first line in preimage differs from first line in
> postimage? =A0The look as if they are the same:
>
> =A0- =A0 =A0 =A0 for (i =3D 0; i < extra_hdr_nr; i++) {
> =A0+ =A0 =A0 =A0 for (i =3D 0; i < extra_hdr.nr; i++) {
>

Maybe some space... :)
>
> The problem is when you are asking about tracking a subset of lines
> that appear in postimage of a patch. =A0For example if we ask for
> history of
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(&buf, extra_hdr.item=
s[i].string);
>
> line, should we track history of
>
> =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < extra_hdr.nr; i++) {
>
> line which appears in relevant diff chunk? =A0If not, how we should
> detect which line in preimage (if any) corresponds to given line in
> postimage?

If I understand correctly, that is as following.

@@ -1008,29 +1000,29 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
               add_signoff =3D xmemdupz(committer, endpos - committer +=
 1);
       }

-       for (i =3D 0; i < extra_hdr_nr; i++) {
-               strbuf_addstr(&buf, extra_hdr[i]);
+       for (i =3D 0; i < extra_hdr.nr; i++) {
+               strbuf_addstr(&buf, extra_hdr.items[i].string);
               strbuf_addch(&buf, '\n');
       }

Here, the user only ask for tracking the strbuf_addstr line. And we
find the above diff hunk. I think we can then find what the line would
be in the preimage using @@ -1008,29 +1000,29 @@.  The strbuf_addstr
is located at
1000(the postimage start line number)
+3(the context number)
+1(the number of lines '+' before this line) in the postimage,
and we can calculate its line number in the preimage by the same way
1008
+3
+1(the number of lines with '-' before this line).

How do you think about this method?

Regards!
Bo
