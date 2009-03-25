From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: add various git-difftool tests
Date: Tue, 24 Mar 2009 20:57:32 -0700
Message-ID: <402731c90903242057g47cdcb2an39bbd95ff80584c6@mail.gmail.com>
References: <1237797676-32047-1-git-send-email-davvid@gmail.com>
	 <1237797676-32047-2-git-send-email-davvid@gmail.com>
	 <7vr60m9vca.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKGf-0001hs-DT
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbZCYD5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 23:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbZCYD5f
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:57:35 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:7431 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbZCYD5e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 23:57:34 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3805416wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 20:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Miq2dO4TvqpnTmc4G2uBmaSel+5WM1UCXQUk7w3dEiI=;
        b=sG76W+PX3pdIgIsf5NLjAlD4X1AFuKu2i3bwrYdH6C34amtR5SYh7NBhAGwAXVmQlB
         9ooo+opkm3vcb/tGdbjNMFHj3y8DtEOiIfUfuxxNhhRx6298j2wS6gWRs1SyhwcUMzri
         SBRUdMWfKMCIGal1HI/RrfHuDoKyWT1q4wpF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VSJ6sniTaXgZNuHlX3hh5TY7gp46rpiGfDMJ0XcA4R6Z+MspHBKk6XXtya0tVhmjxc
         Mjq5YyTzT1JaR8ljseCJ7F8lVSG0JJqN1jGO8Rcwv7LOuKbBFeypUhgBSa14hLHb7gnE
         Zu2//1HJu9SxmP903I7OtzP5+oitvfhlPrs3g=
Received: by 10.142.153.8 with SMTP id a8mr3717781wfe.94.1237953452811; Tue, 
	24 Mar 2009 20:57:32 -0700 (PDT)
In-Reply-To: <7vr60m9vca.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114553>

On Tue, Mar 24, 2009 at 7:42 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Aguilar <davvid@gmail.com> writes:
>
>> +remove_config_vars()
>> +{
>> + =C2=A0 =C2=A0 # Unset all config variables used by git-difftool
>> + =C2=A0 =C2=A0 git config --unset diff.tool
>> + =C2=A0 =C2=A0 git config --unset difftool.test-tool.cmd
>> + =C2=A0 =C2=A0 git config --unset merge.tool
>> + =C2=A0 =C2=A0 git config --unset mergetool.test-tool.cmd
>> + =C2=A0 =C2=A0 return 0
>> +}
>> +
>> +restore_test_defaults()
>> +{
>> + =C2=A0 =C2=A0 # Restores the test defaults used by several tests
>> + =C2=A0 =C2=A0 remove_config_vars
>> + =C2=A0 =C2=A0 unset GIT_DIFF_TOOL &&
>> + =C2=A0 =C2=A0 unset GIT_MERGE_TOOL &&
>> + =C2=A0 =C2=A0 unset GIT_DIFFTOOL_NO_PROMPT &&
>
> I thought some shells' "unset" returns non-zero status when is given =
an
> already unset variable. =C2=A0I suspect you would want to drop the &&=
 chain
> just like you did for remove_config_vars for the same reason.


Ah, I learn something new everyday.  Thanks.
I've addressed these notes and am sending patch v2 now.



>
>> + =C2=A0 =C2=A0 git config diff.tool test-tool &&
>> + =C2=A0 =C2=A0 git config difftool.test-tool.cmd "cat \$LOCAL"
>> +}
>
> 'cat $LOCAL' would be much easier to read, wouldn't it?
>
>> + ...
>> +# Specify the diff tool using $GIT_DIFF_TOOL
>> +test_expect_success 'GIT_DIFF_TOOL variable' '
>> + =C2=A0 =C2=A0 git config --unset diff.tool &&
>
> You might want to lose && here in case the user told an earlier test =
that
> sets the configuration to some value skipped (or such test failed), o=
r
> perhaps later somebody adds tests before this one that leaves the con=
fig
> without this variable.
>
> Other than that I didn't see major breakages.
>
> Thanks.
>



--=20
    David
