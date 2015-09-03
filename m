From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] t9821: use test_config
Date: Thu, 03 Sep 2015 09:52:23 -0700
Message-ID: <xmqqfv2vla2g.fsf@gitster.mtv.corp.google.com>
References: <1441272887-72633-1-git-send-email-larsxschneider@gmail.com>
	<1441272887-72633-2-git-send-email-larsxschneider@gmail.com>
	<CAPig+cTzeUKiFVvdsGBvvUg+9qOw6RWHdzuTgQRTWm5w0CeRcQ@mail.gmail.com>
	<1C0CF9F4-29EA-4EE0-9DD1-071D57BCFD8B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:52:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXkT-00068t-R2
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbbICQw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:52:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35528 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbbICQwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:52:25 -0400
Received: by pacfv12 with SMTP id fv12so52910675pac.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iWLBaiVnhlYwoAD7c8dd1VGprY7bi+RpXCq7Qc/gA68=;
        b=bo7YeWzVrEFBilw/GGD+no+06WO5gyqaqLyI8fnzbQlGMIzhfxKPYZOy60/ogkGVdI
         sd1PoBUoKFjOruIe8pFJp2paCIU/8QJ+WahjNvdXqM5jlbFJo1i02WgYPwo6p9uRCBjy
         N8UNtES97jWyfAJ4FOuF036NNoAFcgC0onYboS9Jkxxt873M8ci+jdipJ+EdsYJ7jvHC
         4lkUSDcUjGsSeJtMXXr4OYHsZZJ2jZlMoq5QP6AlSlR33MtXoLFlZzSPGQnRt/7FEB39
         wB1+pSwXG8yM3IB+VWtKr+cjncfC6H7sGn0YtHtbOPwdcwT2ph021lilCfk1sSLzbLfC
         cRFA==
X-Received: by 10.68.194.170 with SMTP id hx10mr70099570pbc.64.1441299144819;
        Thu, 03 Sep 2015 09:52:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id fp5sm25804838pbb.94.2015.09.03.09.52.24
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 03 Sep 2015 09:52:24 -0700 (PDT)
In-Reply-To: <1C0CF9F4-29EA-4EE0-9DD1-071D57BCFD8B@gmail.com> (Lars
	Schneider's message of "Thu, 3 Sep 2015 17:13:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277229>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 03 Sep 2015, at 15:04, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
>> On Thu, Sep 3, 2015 at 5:34 AM,  <larsxschneider@gmail.com> wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>> diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
>>> index 81e46ac..5a26fec 100755
>>> --- a/t/t9821-git-p4-path-variations.sh
>>> +++ b/t/t9821-git-p4-path-variations.sh
>>> @@ -45,7 +45,7 @@ test_expect_success 'Clone root' '
>>>        (
>>>                cd "$git" &&
>>>                git init . &&
>>> -               git config core.ignorecase false &&
>>> +               test_config core.ignorecase false &&
>> 
>> test_config ensures that the config setting gets "unset" at the end of
>> the test, whether the test succeeds or not, so that subsequent tests
>> are not affected by the setting. However, in this case, since the $git
>> repository gets recreated from scratch for each test anyhow, use of
>> test_config is superfluous. In fact, it may be slightly
>> contraindicated since it could mislead the reader into thinking that
>> state is carried over from test to test. (Not a big objections, but
>> something to take into consideration.)
> OK. Do I need to do anything to take the PATCH suggestion back?

You can just say "I retract this one because...", which you just
did.

For the path-encoding patch, I think the following is all that is
necessary to be squashed in, but please double check (unless you
have some other improvements you want to make on top of v6 of that
patch, no need to reroll only for the following).

Thanks.


 t/t9822-git-p4-path-encoding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index e507ad7..3646580 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -39,7 +39,7 @@ test_expect_success 'Clone repo containing iso8859-1 encoded paths with git-p4.p
 	(
 		cd "$git" &&
 		git init . &&
-		test_config git-p4.pathEncoding iso8859-1 &&
+		git config git-p4.pathEncoding iso8859-1 &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		UTF8="$(printf "$UTF8_ESCAPED")" &&
 		echo $UTF8 >expect &&
