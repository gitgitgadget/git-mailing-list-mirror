From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] submodule: implement `module_name` as a builtin helper
Date: Wed, 5 Aug 2015 09:29:37 -0700
Message-ID: <CAGZ79kb8q_OzdMTxeNQo6t0T9Ay8TJkMPPqZU-G0CkOZ9rA_hA@mail.gmail.com>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
	<1438733070-15805-2-git-send-email-sbeller@google.com>
	<CAPig+cQtoWF_9Km4H7MXDf7ySQNUP9gncxkrV3NFTrULA8fbbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 18:29:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN1ZX-0001SH-93
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 18:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbbHEQ3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 12:29:39 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35906 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbHEQ3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 12:29:38 -0400
Received: by ykeo23 with SMTP id o23so39735170yke.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4UjsNQKETdqMpQ/EqQwZp+ct18RRv5ocz7t0c08+PRs=;
        b=Dt8ORNyby7oid22OOzSTU7JwsKx5EhlnFPpS1jlXVzrC521PJ1AtsjszOVOaPESv/t
         fV4Hc6D53nDBqseUZ5l/qKnOVtGOJl1xUDyhRHwvb8RlHZ9WtAGyIzaA9s3rwndlvxyv
         Cqok5dqxIQGE3zmDOtE1pqUE1VIiDRpacnXGzhRvq5GxJ+L1FWd/ihA5odBgME4Jkuem
         oSnAEMcJxq37UAOtzyVFm4fYpcIHTRING/Ul5rsxjTqBct0wQj4hQ0KRTJogu1CFk5te
         J/F338+6w2AJQ8janDBTJYjaHL7X2pWM330qMSIQBVWdB0Du3k3GU/1zwG0/OBRfUmTp
         FQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4UjsNQKETdqMpQ/EqQwZp+ct18RRv5ocz7t0c08+PRs=;
        b=LGwmAAVF0U816Ub7v9CeF4lh2NhD5YEuZUQqqNPd7MriLMrYypqk3aJ5FoLs1Aq9n+
         vHX+38R3KY5JLDSgzLgx6Ij0fo6XwaxqYbD+4UhE5wbvKsxAbckYJKe7GYNEn/8HkB0r
         iHhcfy5JinZUYZ/JXgmbOtEtSdbNaNxcCD6l7Y/pEAS5JMqNI+an4HeJCIfE9NNh7d8K
         5Gr1m5CHD0gw00YOVtvq7zYdOViDSgv5joY9vmfxtdY1SnOFYpJrtS6CNEKvm5sHA2ej
         EH/TENlXvi0JhyPE2pw7G6QCKwmbuVIhNY4SFBJJQ/1SfoSt9GDu28dvTWme1Ao3Y1ri
         C9kg==
X-Gm-Message-State: ALoCoQlv6rovlg6QHS969nmwX2EA6enAbR5tQ2BajtcoV8HLz09DpLniRBIJNhokzieMK2fSF8kh
X-Received: by 10.170.212.65 with SMTP id d62mr10127429ykf.115.1438792177272;
 Wed, 05 Aug 2015 09:29:37 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Wed, 5 Aug 2015 09:29:37 -0700 (PDT)
In-Reply-To: <CAPig+cQtoWF_9Km4H7MXDf7ySQNUP9gncxkrV3NFTrULA8fbbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275374>

On Tue, Aug 4, 2015 at 5:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 4, 2015 at 8:04 PM, Stefan Beller <sbeller@google.com> wrote:
>> The goal of this series being rewriting `git submodule update`,
>> we don't want to call out to the shell script for config lookups.
>>
>> So reimplement the lookup of the submodule name in C.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index cb18ddf..dd5635f 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -98,6 +100,48 @@ static int module_list(int argc, const char **argv, const char *prefix)
>> +static int collect_module_names(const char *key, const char *value, void *cb)
>> +{
>> +       size_t len;
>> +       struct string_list *sl = cb;
>> +
>> +       if (starts_with(key, "submodule.")
>> +           && strip_suffix(key, ".path", &len)) {
>> +               struct strbuf sb = STRBUF_INIT;
>> +               strbuf_add(&sb, key + strlen("submodule."),
>> +                               len - strlen("submodule."));
>> +               string_list_insert(sl, value)->util = strbuf_detach(&sb, NULL);
>> +               strbuf_release(&sb);
>
> Why the complexity and overhead of a strbuf when the same could be
> accomplished more easily and straightforwardly with xstrndup()?

fixed.

>
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int module_name(int argc, const char **argv, const char *prefix)
>> +{
>> +       struct string_list_item *item;
>> +       struct git_config_source config_source;
>> +       struct string_list values = STRING_LIST_INIT_DUP;
>> +
>> +       if (!argc)
>
> Do you mean?
>
>     if (argc != 1)

doh! Yes I meant that.

>
>> +               usage("git submodule--helper module_name <path>\n");
>> +
>> +       memset(&config_source, 0, sizeof(config_source));
>> +       config_source.file = ".gitmodules";
>> +
>> +       if (git_config_with_options(collect_module_names, &values,
>> +                                   &config_source, 1) < 0)
>> +               die(_("unknown error occured while reading the git modules file"));
>> +
>> +       item = string_list_lookup(&values, argv[0]);
>> +       if (item)
>> +               printf("%s\n", (char*)item->util);
>> +       else
>> +               die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
>> +       return 0;
>> +}
>> +
>>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>>  {
>>         if (argc < 2)
>> @@ -106,6 +150,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>>         if (!strcmp(argv[1], "module_list"))
>>                 return module_list(argc - 1, argv + 1, prefix);
>>
>> +       if (!strcmp(argv[1], "module_name"))
>> +               return module_name(argc - 2, argv + 2, prefix);
>> +
>>  usage:
>>         usage("git submodule--helper module_list\n");
>>  }
