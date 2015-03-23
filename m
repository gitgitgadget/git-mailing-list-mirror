From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Sun, 22 Mar 2015 21:56:48 -0400
Message-ID: <CAPig+cShTKEVovMRWWPVn7cVMUF7J+ZT_eK4OfOGgn2H4H0TdA@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
	<CAPig+cR-87-dWXUKoKvphrdb_Y=7268G5uerAiPYDsj-UQiuRw@mail.gmail.com>
	<CACRoPnTXH+HDD42H2ca7b+OPF15v2TxM+y+NRRi2CS_Xg3tGEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 02:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZrbq-0000Hw-MT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 02:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbCWB4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 21:56:50 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34818 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbCWB4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 21:56:49 -0400
Received: by ykfs63 with SMTP id s63so65634085ykf.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 18:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5MoehlvJ09bPBndjehXgtAz5YxIC4suCTGFlMCiKvPI=;
        b=dDkPXloGTMVCbbchsoossKI5xekmuARCz5WeIA2cBmSO+Fd5CaC+hi9BiY8l9JnDy8
         G6CCSIGwIhuKzqMHqSDTVKb3nr6AQ5meGdgXOoyKE/nCpNiV8EXGbHriIfZa4PuP0xKb
         Tok7cTATJvWJye+ORg8EerdoTqr9Ow0kB9UNAd8ytG4/l1lCCLH0vo3GJGMmdL33T3E+
         JOJkGw7/jXyDSm5gdmKlZnuT4lJxlWAjMQgNE22SiRh2e2278cLC3FxtE2hvD0KFZ39H
         4NBjZMDjc+5kP+QdAkGrDcAuEz4nuNNl5ceQdHNVXQwXukA9hYxVMgJmJdSJB4jX6jbq
         KMFw==
X-Received: by 10.236.105.210 with SMTP id k58mr91676468yhg.52.1427075808478;
 Sun, 22 Mar 2015 18:56:48 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 18:56:48 -0700 (PDT)
In-Reply-To: <CACRoPnTXH+HDD42H2ca7b+OPF15v2TxM+y+NRRi2CS_Xg3tGEw@mail.gmail.com>
X-Google-Sender-Auth: 8-Ksv7AnyVMfXRhVf2u3zxqdJFc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266114>

On Sat, Mar 21, 2015 at 1:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> On Thu, Mar 19, 2015 at 3:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Mar 18, 2015 at 3:04 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
>>> index f61b40c..5b0a666 100755
>>> --- a/t/t0302-credential-store.sh
>>> +++ b/t/t0302-credential-store.sh
>>> @@ -6,4 +6,115 @@ test_description='credential-store tests'
>>> +test_expect_success 'when xdg credentials file does not exist, only write to ~/.git-credentials; do not create xdg file' '
>>
>> These test descriptions are quite long, often mirroring in prose what
>> the test body already says more concisely. I generally try to keep
>> descriptions short while still being descriptive enough to give a
>> general idea about what is being tested. I've rewritten a few test
>> descriptions (below) to be very short, in fact probably too terse; but
>> perhaps better descriptions would lie somewhere between the two
>> extremes. First example, for this test:
>>
>>     "!xdg: >.git-credentials !xdg"
>>
> I will make the test descriptions shorter. However, I don't think the
> test descriptions need to be so terse such that a separate key is
> required. e.g. I will shorten the above to "when xdg file does not
> exist, it's not created.", or even terser: "when xdg file not exists,
> it's not created.". I don't think symbols should be used, as many
> other test descriptions do not use them.

Your updated test descriptions all sound fine.

>>> +XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME && helper_test store
>>> +unset XDG_CONFIG_HOME
>>
>> It's hard to spot the "helper_test store" at the end of line. I'd
>> place it on a line by itself so that it is easy to see that it is
>> wrapped by the setting and unsetting of the environment variable.
>
> Thanks, will fix. Although now it looks weird that the "export" is the
> only one with a continuation on a single line, so I split all of them
> so that they each have their own line.

An &&-chain outside of a test is not meaningful in this case, so I
meant either this:

    XDG_CONFIG_HOME="$HOME/xdg"
    export XDG_CONFIG_HOME
    helper_test store
    unset XDG_CONFIG_HOME

or, slightly more compact (using && just to combine the assignment and
export on one line):

    XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME
    helper_test store
    unset XDG_CONFIG_HOME
