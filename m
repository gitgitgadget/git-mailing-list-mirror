From: Joshua Roys <roysjosh@gmail.com>
Subject: Re: Unreachable code in builtin-merge.c ?
Date: Fri, 23 Oct 2009 11:14:43 -0400
Message-ID: <4AE1C863.3070907@gmail.com>
References: <B221C4384AE5104EB414A877DFD0372C0B0092C0C5@DEWDFECCR04.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Zivkov, Sasa" <sasa.zivkov@sap.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 17:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Lqv-0004qe-TI
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 17:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbZJWPOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 11:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZJWPOn
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 11:14:43 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:43680 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbZJWPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 11:14:43 -0400
Received: by ywh40 with SMTP id 40so6473062ywh.33
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=bLX3BSd5jX+aZGhfBTmgXqb5i+fkh86BlhhC3e2G4VM=;
        b=vP+Bhw3M5uUGO7wBwzldqJnL7AKlTzo7Nr3UpHMoRsn4UkaREGbN0ETzLPQGzZae/l
         SnDdldiSUFZz1T/8R1pU7NluHwueIivX1mrq4oHYiWqglNCPY8RMPAHEJp6agnJi9emJ
         v+zqd+Pt0FntGjmsTiDdnrI6X78dA9GYUjcZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gXj75YvkjUHy0mdOkY0pR1AlzvDjiA1ru4dVZQAbSpe8AtWzjIhZ++rnbR4z+9131d
         thLyMiYjphcWUmyRMoxuQ3WoHWM6qOHIVSsVDT+tHOEyFkaTzgZCtTSrulG0I9nAVTyJ
         OwVs4vhdiwaJFwhIKd/IxeLkJsWC42cRG5tdI=
Received: by 10.101.162.10 with SMTP id p10mr922282ano.92.1256310887375;
        Fri, 23 Oct 2009 08:14:47 -0700 (PDT)
Received: from sis-JRR.stl.gtri.gatech.edu (sis-JRR.stl.gtri.gatech.edu [130.207.197.190])
        by mx.google.com with ESMTPS id 7sm190624yxd.62.2009.10.23.08.14.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Oct 2009 08:14:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-2.7.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <B221C4384AE5104EB414A877DFD0372C0B0092C0C5@DEWDFECCR04.wdf.sap.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131108>

On 10/23/2009 11:03 AM, Zivkov, Sasa wrote:
> In the try_merge_strategy function the expression in the following if=
 statement seems to always evaluate to TRUE:
>
>          if (!strcmp(strategy, "recursive") || !strcmp(strategy, "sub=
tree")) {
>
> If strategy is "recursive" then !strcmp(strategy, "subtree") evaluate=
s to TRUE.
> If strategy is "subtree" then !strcmp(strategy, "recursive") evaluate=
s to TRUE.
> If strategy is neither "recursive" nor "subtree" then any side of || =
evaluates to TRUE.
>
> Looks like the code in the else block is unreachable?
>
>
> Sa=B9a =AEivkov
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello,

Not quite :)  The strcmp() function actually returns 0 when the strings=
=20
match (I know, it looks weird "!strcmp" -> "not string compare?!"), so=20
the "if" really means: "if strategy is equal to 'recursive' or=20
'subtree', do the following..."

Hope to help,

Josh
