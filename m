From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] submodule deinit test: fix broken && chain in subshell
Date: Tue, 3 May 2016 12:30:33 -0700
Message-ID: <CAGZ79kZX-UkmTXG=s8qXe-RKynW3Oitk0URZk-K81UOSGfSeEQ@mail.gmail.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<1462227844-10624-2-git-send-email-sbeller@google.com>
	<xmqqvb2vnmh0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:30:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axg1p-0005uq-QV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbcECTag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:30:36 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:32941 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcECTae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:30:34 -0400
Received: by mail-io0-f173.google.com with SMTP id f89so33075736ioi.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZHBk8kcrHnG6OgQDPsgD0SJAJh7mi6896UO4C/tYljk=;
        b=Yl/c/7OM1NKXJPlx8Mr1hfTdGMc0YFFATME6v7znn339N2FW4EWUXxgd6105k402tP
         TUBko9Ce5bi9tjcKwurWVUD5+cA1X9ovARuZntW/sArXEMpwW/m1HS1Mlc3gF9r8bwwX
         bxilM9A2d/pjfP+URP3f3sSNdF8yQTr75e5hrBA30Kt4/hhVpccb3p3MPv6KPIdgXyxj
         Bg6E3G6a9uw2XfbW8iffllZctrFU3+CK0hIYr2QfzlIC7ksmmqO7ORmQdXfbutmhDLc3
         FSX+47sD3JEF1fwuSEj9uPBdWXPBqRyug2UeE8yVMQ+FtKEgx/a36u5dfborg8p45wl9
         IJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZHBk8kcrHnG6OgQDPsgD0SJAJh7mi6896UO4C/tYljk=;
        b=eb/8ikygOAHALKjl9r2q7DuOeI8NEuYBPTdIA+OYJgZSdlIBy6UVLRGf/znB3oOZj+
         acrEoWLtv1OceDXisAkoywobjHdMAaS23cbJlynFY5QYW0+fKkQCjiNSEMqoLXzNHsLt
         Li8D1oND51ws+KJRMl9YzAD1ZQNoXJmDUL69+FiLh0VLOn9TNc0poB5lrFOorIhbcfP5
         h+6Jg5JC3IYC43haQjCVHGwrsXU5aO6RH+kYtxYm9M/H+uipY4z248m7mOQhFD3x/NQr
         8b9ggpicljXLajKeYGSjRFdzLvh1JyFbEsQd4DeV7QT8kBN9nfUUiRlWoZdOjohVDzNr
         qvtQ==
X-Gm-Message-State: AOPr4FXO/IFdagR1hJVimkwONcKqQBpzxOyjh0zJiWJEkkaYEq9yuQBH3tSIhqJh6XQ3m5epXcF1P8Krmvgvms5y
X-Received: by 10.107.174.205 with SMTP id n74mr5447028ioo.96.1462303833771;
 Tue, 03 May 2016 12:30:33 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 12:30:33 -0700 (PDT)
In-Reply-To: <xmqqvb2vnmh0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293444>

On Tue, May 3, 2016 at 9:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  t/t7400-submodule-basic.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index 814ee63..90d80d3 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -914,7 +914,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
>>               git init &&
>>               >file &&
>>               git add file &&
>> -             git commit -m "repo should not be empty"
>> +             git commit -m "repo should not be empty" &&
>>               git submodule deinit .
>>       )
>>  '
>
> Thanks.
>
> As this was introduced by 84ba959b (submodule: fix regression for
> deinit without submodules, 2016-03-22), which was merged to the
> mainline at v2.8.0-rc4-8-g2a4c8c3 and applies there, let's queue it
> there.

Ok, I'll reroll there with an improved 2/3 on top of v2.8.0-rc4-8-g2a4c8c3.
