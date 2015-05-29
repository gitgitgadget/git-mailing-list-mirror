From: Stefan Beller <sbeller@google.com>
Subject: Re: BUG: Wrong error message when access to .git directory denied
Date: Fri, 29 May 2015 09:45:13 -0700
Message-ID: <CAGZ79kZPTpJjLsKSd6E8vQ0HFuSeCH5Hr_LBhSjx9=SQdQhOBQ@mail.gmail.com>
References: <20150529104743.6220a11f@outerspace.dyndns.org>
	<xmqq1thzfll9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonas Berlin <xkr47@outerspace.dyndns.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 18:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyNPN-0004Q1-2m
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbbE2QpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:45:16 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34828 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbbE2QpO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:45:14 -0400
Received: by qgg60 with SMTP id 60so31392096qgg.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3gaQZtMskvF5dj/W8Owm8CwRtsx6/UkVPkGmS4srkSA=;
        b=Kct7ipYsBFLPcVutZhl+h/xPGVbcEgAnV16QHGCgbQEAxFtMSvx0unTc9Ix55bYgao
         2U8+8m9tE8i6u02E6iXGt7alOjfNmt+x9Q/4v+NlOd7sLiacU3eZ4o88itA8/yiTFN43
         fU/HrCnH/Wn82jtTLFNgS61sa/302UhQnyWnfTvmCpVVLo9yXerDkChUhFiBlbodKziq
         TP8lG37bgFxySwkp/8O9doaSKNtdO0KHQeUKzsebxS8UFb9hompnDbQOZmwwHIY1pp8Z
         AfNodwAAG7Mtxfk/Rny/IadZzxJkoM0FNM1uQWhsWOady45iKWQRyoMFH6T7E0jl74Bh
         0/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3gaQZtMskvF5dj/W8Owm8CwRtsx6/UkVPkGmS4srkSA=;
        b=ERS4Mj3zceVzjWPFkC95k9Gj61qh+xCvpca48zuiEY7ttgfT4xGW2VnZs2SZkk9ShH
         L78OAurkMIBKrS+JosUCrna4SwCDR2wSl4I4T4+zljAsX8Fpwaa8fFhZWVpnzxIYHTw9
         MJ4Yt0oGPhdHNTbSl3AabC+JfeLGKNWj7uksjcmF7/msGrzeh4n/r6Zbnns4CpbQGdVT
         dk6GrZleDy/WUlxluLN/EePWv2DRfgkr3fAeUltRtH3gKl1nJwJpEl5wJWiERWARN1cp
         ZTomyz/dCc9g15NVMcTpnNmrfa4LQ8W/lZ85n/trzbhzX7kDEC+x6tT5Aknu0AS1tRGZ
         R9eQ==
X-Gm-Message-State: ALoCoQkShrZmyl4GSkkLxzVK+uDiWR7Bt6gBYf4BJoKiZjrlIwxz15JnQ4JqtqoQa0R6sydYumOW
X-Received: by 10.140.133.9 with SMTP id 9mr11002306qhf.5.1432917913166; Fri,
 29 May 2015 09:45:13 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 29 May 2015 09:45:13 -0700 (PDT)
In-Reply-To: <xmqq1thzfll9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270256>

On Fri, May 29, 2015 at 8:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonas Berlin <xkr47@outerspace.dyndns.org> writes:
>
>> Severity: Low
>> Impact: Confusion
>
> ;-)
>
>> Git version: 1.9.1
>>
>> If I don't have permissions to access the .git folder of a non-bare
>> git repository, I get the following output:
>>
>>   fatal: Not a git repository (or any of the parent directories): .git
>>
>> Expected output:
>>
>>   fatal: Permission denied while accessing .git directory
>
> But the thing is, .git being unreadable simply means we do not know
> if it is a .git directory, or a random directory that does not have
> anything to do with Git that happens to have that name.
>
> So "Not a git repository" is the best Git can say.

fatal: Permission denied while accessing .git directory

does not imply we're having a git repository here at all, but rather
sounds like "We wanted to check for you if this is a git repository,
but we cannot do that as we lack permissions to do so.

So git doesn't know if it is inside a repo or not, so the actual error message
"Not a git repository" is wrong. It's just that the current permissions cannot
tell if we're in a repository or not.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
