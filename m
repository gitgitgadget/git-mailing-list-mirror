From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 1/2] submodule: implement `module_list` as a builtin helper
Date: Mon, 3 Aug 2015 15:13:24 -0700
Message-ID: <CAGZ79kZL2S2jJ8HmQP6Es_4=5nCt=MwpcDcB0RPv7Yw=1NDodA@mail.gmail.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-2-git-send-email-sbeller@google.com>
	<xmqqmvybakjl.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY=39j4H=62=VZRm4VOcqzgOAU6tDpJVsqdeqnPtB8hQQ@mail.gmail.com>
	<xmqqbneo6nas.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNzA-0003TL-80
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbbHCWN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:13:26 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34548 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbHCWNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:13:25 -0400
Received: by ykax123 with SMTP id x123so123067298yka.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=63N82cQkFHH4MUSIy2jZYRFBMCeYbRiN9uRjIB8l0Ng=;
        b=P7KzraVUEFFWKJrnC8PdR+yv+hL87H+6O0eAk6GS73IwkcSpKscByeV1Iq4i1kaNjw
         I57A/9qtNn5sV4Ud/jljEf9M0IX131KwZ0a/ieinQ4NCYmsudQJw1A8MGlJdvlsJzEyP
         cOspVgdWtFKDnUrfY6GWT6v8LBwxazXric2ov7eziIOdH4i/eA3p4JksxiI98dmm4Uh7
         YP2DFwI2B6Pzxtj525bmuyW3xrMZgHz/OMbsNqwTUOjjP95WLe4q7g8HpoTb6VQf+EQN
         s2x6O7ENnCcGb4a+tcS+MCQK4jPhD3NhB/MgekthTCRE77VR6YOUbQZ/COWHcVwpMOfx
         Esag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=63N82cQkFHH4MUSIy2jZYRFBMCeYbRiN9uRjIB8l0Ng=;
        b=DHHtxYEK0G7qBDFO+7f05UninVULeRaSf6JfMqGufYch5pLjkbrQreP09ZaNwDeLRK
         ZqeYyPWCsMtJi2fcG/spGnXRQrgZr+2vLfejwbneetzO4NExXopRwieVz4tQkio3IyT/
         DakApCWwghVPdNAgXIoKB1vkAjBMUhWDSAXsBO+y2NMXmE5D1pZTf1mRNQWkuCGFMsr2
         W81Zop4RmAU/5Paf3SPtauVQGrBd8k3/aqqBPx0EkizKBdw3c/+Uqa0GOzbh/5xx5er2
         rYBfXB+c6WbgeT12/GehZHMgRHF1E5EEpLVJGjLseNvE/K4aNe+LgFlvfdm08d2EJPNd
         efJg==
X-Gm-Message-State: ALoCoQn90d/cC7noOtRJjKJx3O7K3Oopr7qFkSf0HDZliLiqTNS0efdA/TGww1ZH2CEG9O27E28g
X-Received: by 10.170.135.74 with SMTP id b71mr371192ykc.16.1438640004962;
 Mon, 03 Aug 2015 15:13:24 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 3 Aug 2015 15:13:24 -0700 (PDT)
In-Reply-To: <xmqqbneo6nas.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275217>

On Mon, Aug 3, 2015 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Jul 31, 2015 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> +static const char * const git_submodule_helper_usage[] = {
>>>> +     N_("git submodule--helper --module_list [<path>...]"),
>>>
>>> Yuck.  Please do not force --multi_word_opt upon us, which is simply
>>> too ugly to live around here.  --module-list is perhaps OK,
>>
>> I agree there. The way you word it here, it sounds as if the mixture
>> of dashes and underscores are a problem.
>>
>>> but
>>> because submodule--helper would not have an default action, I'd
>>> prefer to make these just "command words", i.e.
>>>
>>>     $ git submodule--helper module_list
>>
>> Why would you use an underscore in here as opposed to a dash?
>>      $ git submodule--helper module-list
>>
>> I went with --module-list for now as I see no reason real to make it
>> a command word for now ...
>
> The biggest reason why we should not add more --command-mode is to
> avoid confusion (and copy & paste misdesign by others).  If you use
> the command-word interface, it is crystal clear that
>
>  (1) the word 'module_list' must be the first token after the
>      subcommand name, no need to parse "subcmd --opt --cmd", and
>      mislead the users to think incorrectly that ...
>
>  (2) ... "cmd --optA --cmd1 --optB --cmd2" might be allowed, which
>      would lead you to add code to reject, saying "cmd1 and cmd2 are
>      incompatible".
>
> So I'd prefer to see it fixed before you start supporting more
> commands in submodule--helper.  It will need unnecessary patch noise
> to fix it later.

So we had this discussion some time ago [1] and my understanding from back
then was to rather have --command-mode instead of subcommand words because
that's what most git commands use nowadays, so we don't want to add more
of the competing style. It's also easier to work with as we have a powerful
option parsing implementation.

It seems your opinion has swayed. I'll change it then.

[1] $gmane/254076 or $gmane/231376/focus=231478
