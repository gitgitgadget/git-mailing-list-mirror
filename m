From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: force "unmerged" for same-file auto-merges
Date: Sat, 27 Mar 2010 14:26:59 +0530
Message-ID: <2e24e5b91003270156r11ae9155s6e00a2ab27e9f479@mail.gmail.com>
References: <hobqoc$5h3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 09:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvRpN-00009q-GA
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 09:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305Ab0C0I5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 04:57:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38503 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0C0I5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 04:57:00 -0400
Received: by vws8 with SMTP id 8so1816389vws.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 01:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zbDnH8lnavNrRDD5hSI6G1azmg4oPSgpkGoHAZUQPFE=;
        b=HjD0CFG0cUAtAi14yvC4s7N1lja7WVK06PGJCy2guBwE9mlmiTtsyhIMDbr2sthnQa
         3RJ1557HOTq1zHLaJ3lodGHdlBOB1KhjaFRrWe8FYb1BSaf+2M1KSBCePsr6L8qhjIFb
         RJUKyz6PtUGLkwcFwDj3mKFrJefla1JqGAlU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WV1u28qAjrGfMHDJCr2/tPRKzpOHsE+NoQNs0YOOAIX5EqQdysMY7IUEvbd7GmSkv5
         GuA8sjYEfvi1zVG6ZginzXCDNLNd9TZ/Z7nLEzVfXrsR5CMwIY0Njfjjm0K6xP3GFRNb
         dNIP3b8F6zkSJgkDQJMQUx1JLcHc0J1xWh6fw=
Received: by 10.220.100.212 with HTTP; Sat, 27 Mar 2010 01:56:59 -0700 (PDT)
In-Reply-To: <hobqoc$5h3$1@dough.gmane.org>
Received: by 10.220.48.22 with SMTP id p22mr1249805vcf.213.1269680219900; Sat, 
	27 Mar 2010 01:56:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143322>

On Wed, Mar 24, 2010 at 7:14 AM, Neal Kreitzinger <neal@rsss.com> wrote=
:
> Scenario: =C2=A0"same-file auto-merge": =C2=A0when two different peop=
le change the
> same file in their separate repos. =C2=A0Their changes do not conflic=
t in the
> sense that they are changes to the same lines. =C2=A0However, their c=
hanges do
> conflict in the sense that the resulting merged logic is incorrect.

You're not being pessimistic enough :-)  A ".h" file that changed only
on one side can cause the same logic issues

> Desired Solution:
> Perform same-file auto-merge and produce auto-merge results, but mark=
 all
> such auto-merged files as "unmerged" so that they must be reviewed/re=
solved
> before a git-commit. =C2=A0The "unmerged" status allows git-mergetool=
 to be run
> (e.g. kdiff3) so that the merged lines can be reviewed. =C2=A0In this=
 way, all
> auto-merged files are reviewed.

No.  What you need is a full blown diff for the merge, with both sides
being compared with respect to the common merge-base.  That diff will
be pretty big, although I'm not sure what diff options would actually
produce that (but I'll bet "-m" figures somewhere).
