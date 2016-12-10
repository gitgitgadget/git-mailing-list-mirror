Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E986E1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbcLJUVA (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 15:21:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:64418 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbcLJUU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 15:20:59 -0500
Received: from [192.168.178.43] ([88.71.224.5]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMTEM-1cHU9a1PmY-008FXK; Sat, 10
 Dec 2016 21:20:44 +0100
Subject: Re: [PATCH v2 4/5] Make sequencer abort safer
To:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
 <20161209190111.9571-1-s-beyer@gmx.net>
 <20161209190111.9571-4-s-beyer@gmx.net>
 <CAP8UFD0hCke_W6C=gOHinpj+G3WCFKf7Cji6zREDer4RUBxKxg@mail.gmail.com>
 <20161210200437.ijmahia6e6xifhk6@sigill.intra.peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <102c7dd1-fa70-6a47-3f13-ddafbce4b13b@gmx.net>
Date:   Sat, 10 Dec 2016 21:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161210200437.ijmahia6e6xifhk6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PQ2+0tuBHKNtQopbDBrSH4snVczBUlrTQOgQm4SCn5ovJptNmL2
 +2uV90xnpxAy+7sHIk1DuXkuWQAnKp23T+yNzPWKekLqKP/kVWvQ+DNkuGFaDuDj0PLG8X7
 ttagkKjfmoKWgB/pCyxUaqameo9seiTr4Y7svnSCsb5pwhNRomJcxq98PrmUfLpVIOY7IQu
 26N5wLp3cuj5xhfKUTLBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NCoZgj9z23I=:zEZk7ecbeux6ucLG915rlJ
 uE9pe7GYrIAQ2EemvSFjYcFy6OsaU5nJXLpwY4DXqX/h8dc+hAT5gAAlrxT2EJmD9mm+YoFVE
 ZzJYSfFT20UBIsDgx9/SPSztVtUNbl9hJp0EYVt/8ju0NnihImwk3BEccZa9wbG3A68XhepS+
 YbpZcplHpxngql/phKUv36qQcZBTdYEZCjJrOBRYaFVHwZRmHrhr1x5X/bfZJ8nx3u63ukHrq
 98kGKn7hJyAKl4RAjhdPRa+ixCu/lKtqyjwN3ANx7QMv+1kTk9XlPjmHHkrfJpMDGTjPQ3mjZ
 8oLyov5IHtTCB0vvyFGU3sdNaG60jxn7z6NgoyjJChWRVIQUUh0DqCyCzL86UQmS+/ZeJ0MHp
 vk6CKf/GzpCwNEJO1FebhBfp4CN3zGXTkLVQ0SbkaqqfWBUtFU67yzmFVLYpHMmHIPtSCooBC
 8mWrxCLl+fXZtEKlYcGq8CYuPAmix2ulk3jMGdh5Spk8r93BhULqk9ZK5xG70g/jhSbnWprcT
 uc6ZJitzQmuukRAXHlJAZ9fYCtngZaUYt4VOl0g/bSYtrigpQkGt69+2ajdqTi2k3A6ofVhha
 ymT/DmkGS6e6W80m7gUXThPtiPSJLyO6uH5zGe5VKX3sHWt828zCss2AZwRBEEjNRBJIE/mZ8
 v5ui7LD3uXT5aOgqsKg2RcvxrD1F2vc3anoBK+invAiR0wt2Pm33qS6K5t6lw0fvJaNrN08Qu
 bVMXYAJoDSz8Y7yoT3hPq6Dnt/KFp8x68IZSPLnMmN0UsvwT1lPZk3SyIBUeZ/sOdN02Nwd1s
 HvssjGC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2016 09:04 PM, Jeff King wrote:
> On Sat, Dec 10, 2016 at 08:56:26PM +0100, Christian Couder wrote:
> 
>>> +static int rollback_is_safe(void)
>>> +{
>>> +       struct strbuf sb = STRBUF_INIT;
>>> +       struct object_id expected_head, actual_head;
>>> +
>>> +       if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
>>> +               strbuf_trim(&sb);
>>> +               if (get_oid_hex(sb.buf, &expected_head)) {
>>> +                       strbuf_release(&sb);
>>> +                       die(_("could not parse %s"), git_path_abort_safety_file());
>>> +               }
>>> +               strbuf_release(&sb);
>>> +       }
>>
>> Maybe the following is a bit simpler:
>>
>>        if (strbuf_read_file(&sb, git_path_abort_safety_file(), 0) >= 0) {
>>                int res;
>>                strbuf_trim(&sb);
>>                res = get_oid_hex(sb.buf, &expected_head);
>>                strbuf_release(&sb);
>>                if (res)
>>                    die(_("could not parse %s"), git_path_abort_safety_file());
>>        }
> 
> Is there any point in calling strbuf_release() if we're about to die
> anyway? I could see it if it were "return error()", but it's normal in
> our code base for die() to be abrupt.

The point is that someone "libifies" the function some day; then "die()"
becomes "return error()" almost automatically. Chances are high that the
resulting memory leak is forgotten. That's one of the reasons why I like
being strict about memory leaks.

However, I cannot tell if mine or Christian's variant is really
"simpler" (with whatever measure) and I also don't care much.

~Stephan
