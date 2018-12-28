Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0903F1F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbeL1UNv (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:13:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50433 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbeL1UNu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:13:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so19692527wmd.0
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=WZtebXz+8n9X4VQdR3awtfSNevJccCUnlP3Y8ZywuFU=;
        b=Q3BjTq5WQF3ijjDW2Ej350ZD1RDJZ6aVTHoIqFqBIwQWYQKJFZknqf34IGBWh6RPT6
         bIMN0bsXcV+n2gUPnvTMQQ2QNRFShBF8I18vwSmqj6pyqRenzTNoQz2epRKMwHl5ojGV
         9pZnx3wvnkq7aUzTpFyi3AXS/YYgrwi1QOCJhWPMYAfj6Ug52IUBFxUwZLLMJG6cP/PA
         SJJFmvZMrO7hfAT7CWBfmzBBDN59eERfdByaaOhJHIcByWs8wlafaf2WrE2MKscFFIEe
         a746F0i+lCqb7A4xazhFvAMSpOCNEGN83Ca9zrbMkgUbCkYSHUETaiXjjN36yYzdabI5
         4t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=WZtebXz+8n9X4VQdR3awtfSNevJccCUnlP3Y8ZywuFU=;
        b=uiByPPu0BKZAGTDskWiTGDh8GUB2dfVp2T0AnhMV7ImVwT1mtHvB7ANhAKO34ZvGow
         enkQPOVVhH+VTAmISnL6lFESVoa0KtqGbyG26TQgnsf5izpx5WFAwqww7sw9U4GYnXe4
         ZIZGaRVK7FH6GioKpW+l+PfNtGMOw+Dx6X+7eUgPHRab5s+7pD79pujQdonNiHVMxHWB
         /s8YmnWd9deq6odzXY2s4PW6nDrOKeRlVLFpTwYmJveN1SZLmHm5F/ZvoxQ0RP7Nqlab
         jb7lX49yHSjAlx5mF9D4p7plkg8U/qDYOTSF/ghgsx2jqQCG37S/4MMo0Mzvn5mptiv9
         GovA==
X-Gm-Message-State: AA+aEWaHipZfXjpEhS3JBHByo6p1blqoBoT3RNTK/TqDVi5skCw0HaAr
        lKDEJlegyXDfBmHtukDNYuIMbWOz
X-Google-Smtp-Source: ALg8bN5Bjd58F2u2U4ZBWekn1pPleoTHsIR9KLoeoPP70i9iPnJlQVBBOiGBuneycL4J9ke3v8ey5w==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr24758396wmj.147.1546028026931;
        Fri, 28 Dec 2018 12:13:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o5sm52357798wmg.25.2018.12.28.12.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:13:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v12 04/26] ident: add the ability to provide a "fallback identity"
Date:   Fri, 28 Dec 2018 11:40:05 -0800
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
        <57a654887e652251ae966ec31b4604dc8222f9c6.1545331726.git.ungureanupaulsebastian@gmail.com>
        <xmqqpntoq8zs.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1812272221380.45@tvgsbejvaqbjf.bet>
Message-ID: <xmqq4laxmmti.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 26 Dec 2018, Junio C Hamano wrote:
>
>> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
>> 
>> > +static void set_env_if(const char *key, const char *value, int *given, int bit)
>> > +{
>> > +	if ((*given & bit) || getenv(key))
>> > +		return; /* nothing to do */
>> > +	setenv(key, value, 0);
>> > +	*given |= bit;
>> > +}
>> 
>> We call setenv(3) with overwrite=0 but we protect the call with a
>> check for existing value with getenv(3), which feels a bit like an
>> anti-pattern.  Wouldn't the following be simpler to follow, I wonder?
>> 
>> 	if (!(*given & bit)) {
>> 		setenv(key, value, 1);
>> 		*given |= bit;
>> 	}
>> 
>> The only case these two may behave differently is when '*given' does
>> not have the 'bit' set but the environment 'key' already exists.
>
> Indeed, this is the case where your version would actually do the wrong
> thing. Imagine that GIT_AUTHOR_NAME is set already. Your code would
> *override* it. But that is not what we want to do here. We want to *fall
> back* if there is no already-configured value.
>
> And of course we won't set the `given` bit if we don't fall back here;
> that should be done somewhere else, where that environment variable (that
> we *refuse* to overwrite) is *actually* used.

OK, so the designed calling sequence of the new "prepare fallback
ident" is that any process that wants to use fallback ident must
call the "prepare" function _before_ making a call to any other
functions (IOW, it is a BUG() if things like git_committer_info() is
called before prepare_fallback_ident() gets called).  Under that
condition, you are absolutely right that the two implementation
behaves differently.

That indeed indicates that this is unfriendly to future callers,
which was the main issue I had with the patch.  A comment before the
prepare_fallback_ident() function to explain that would have helped.

Also the first condition checking bit in *given does not help---it
is quite misleading.  It would have helped if it were

	static void set_env_if( ... )
	{
		if (*given & bit)
			BUG("%s was checked before prepare_fallback got called", key);
		if (getenv(key))
			return; /* nothing to do */
 		setenv(key, value, 1);
		*given |= bit;
	}

Because (author|committer)_ident_explicitly_given would never say
"yes, already" if the setting of fallback MUST be done before using
other API functions in ident.c, it we were to have a check for that
condition, it would be testing for a BUG().  And I wouldn't have
been confused by the code while reviewing.

>> > +void prepare_fallback_ident(const char *name, const char *email)
>> > +{
>> > +	set_env_if("GIT_AUTHOR_NAME", name,
>> > +		   &author_ident_explicitly_given, IDENT_NAME_GIVEN);
>> > +	set_env_if("GIT_AUTHOR_EMAIL", email,
>> > +		   &author_ident_explicitly_given, IDENT_MAIL_GIVEN);
>> > +	set_env_if("GIT_COMMITTER_NAME", name,
>> > +		   &committer_ident_explicitly_given, IDENT_NAME_GIVEN);
>> > +	set_env_if("GIT_COMMITTER_EMAIL", email,
>> > +		   &committer_ident_explicitly_given, IDENT_MAIL_GIVEN);
>> > +}
>> 
>> Introducing this function alone without a caller and without
>> function doc is a bit unfriendly to future callers, who must be
>> careful when to call it, I think.  For example, they must know that
>> it will be a disaster if they call this before they call
>> git_ident_config(), right?

As you can see from this "For example,...", the review comment (and
the "simplified but does the wrong thing" version) was written under
an assumption different from the expected calling sequence the
posted version makes.  What future writers of callers that use the
fallback ident feature must know is (unlike the above) that they
must call the "prepare" before they call git_ident_config() or
anything in ident.c.  A comment before this function that explain
how and when in the program flow this is designed to be used is
needed.

Thanks for a clarification.

