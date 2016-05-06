From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Thu, 5 May 2016 17:23:51 -0700
Message-ID: <CAGZ79kZ4wOQrZETB4UVVRO6oecF-qqjzb9hP6-JenNxFNfjiLw@mail.gmail.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
	<CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
	<20160505012219.GA15090@sigill.intra.peff.net>
	<xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
	<20160505201416.GD9162@sigill.intra.peff.net>
	<xmqqtwic6pxs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 02:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayTYi-00035c-En
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 02:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbcEFAXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 20:23:52 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35092 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbcEFAXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 20:23:52 -0400
Received: by mail-io0-f171.google.com with SMTP id d62so100606703iof.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Jv8RE4wMDrLyEuj+e7BWDg7SPzlcC0NjhUAcpJXweAM=;
        b=SxfdzASqlneGn59kOLu/kbrbLRUuijWPD8qyQyPnEGG3gJ3Lc8elm5GBTuhhEoz+Gg
         R2i4mog/OASKor+RRcytyJxRGANNXr83txZereDbvutXq0azrg1KzTDbPtcZChfWLXvl
         OAwh4olWFRt6xxWXHaE5Du1L/xkMrSbL1cJ8fJ/MprslZgvuIoa0IWPr5yYSqnnItl/v
         4+WW6hxxsRR5k2qxnW/EYldQybzeU3a2IF/FoSxDy65gilXyjgYmbJTmqg1tIeHnHAzG
         wydaQsgRK5JpoIlNRfiDzvTdzStfwHLILDYtYonLEcEmF3T+sdxZbxeDK1IgsZhuhL40
         5FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Jv8RE4wMDrLyEuj+e7BWDg7SPzlcC0NjhUAcpJXweAM=;
        b=B5/mcoACmqat4ybNO4Cs3hWWo5M48RHw31+T1MBPY73PntnklctFgJNjDLziPjdXAB
         HNWt1wgCl9VOme5biAZnllYVIcTEhT99+NesTwXxXCeV0umwe8Du3edCLi63ClQwXQz3
         6ckPB5WDLVXhmNQh5aqKef99hL5teuWlvKsRWba2UloCRuK+uf7r09jKFSPOPdf8EM9D
         Couij1+vjwtV5laZoiHC+pTp2scE36XGr9sAFajNeFXEHN7ZZTRIJV+fVinHKtO7M33G
         JnCE9lYw1iKD76MYjOju1Kk3Pt6LFqjIdGrsJCNjtcyUeYTSc2lb9VFJ32SCt5QY4rRK
         bRSA==
X-Gm-Message-State: AOPr4FWFrfEffx/hR76y0Tt+KsVR/vHnu+yfQphAi8e/YqkNLIedB7T9q7LLPywVm7CIt4+ZvNGMKGwvQS9FggbR
X-Received: by 10.107.53.204 with SMTP id k73mr20153985ioo.174.1462494231173;
 Thu, 05 May 2016 17:23:51 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 17:23:51 -0700 (PDT)
In-Reply-To: <xmqqtwic6pxs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293730>

On Thu, May 5, 2016 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I had originally thought after the final one that we could further clean
>> up by turning prepare_submodule_repo_env() into a static function. But
>> we can't; it gets called in one spot from submodule--helper. However,
>> while looking at it, I did notice that we probably want to squash this
>> into the final patch (since sanitize_submodule_config went away
>> completely):
>>
>> diff --git a/submodule.h b/submodule.h
>> index 48690b1..869d259 100644
>> --- a/submodule.h
>> +++ b/submodule.h
>> @@ -43,19 +43,10 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
>>
>> -/*
>> - * This function is intended as a callback for use with
>> - * git_config_from_parameters(). It ignores any config options which
>> - * are not suitable for passing along to a submodule, and accumulates the rest
>> - * in "data", which must be a pointer to a strbuf. The end result can
>> - * be put into $GIT_CONFIG_PARAMETERS for passing to a sub-process.
>> - */
>> -int sanitize_submodule_config(const char *var, const char *value, void *data);
>> -
>>  /*
>>   * Prepare the "env_array" parameter of a "struct child_process" for executing
>>   * a submodule by clearing any repo-specific envirionment variables, but
>> - * retaining any config approved by sanitize_submodule_config().
>> + * retaining any config in the environment.
>>   */
>>  void prepare_submodule_repo_env(struct argv_array *out);
>>
>>
>> -Peff
>
> Hmph, Stefan, do you want to keep this (if you want to resurrect the
> function in some future, for example)?

IMHO it is easier to revert or rewrite than to carry unused code?
Unused code is not tested and untested code is broken code.
And relying on broken code in the future will guarantee bugs.
(Sure new code may also have bugs, but I just think that bugs
in newly written code can be fixed easier)

I would prefer to get rid of it, i.e. taking that patch.

Thanks,
Stefan
