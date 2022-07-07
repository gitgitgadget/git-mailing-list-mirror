Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942B6C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 19:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiGGTz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiGGTz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 15:55:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151F326F8
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 12:55:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 196-20020a6300cd000000b0040c9c64e7e4so9120442pga.9
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HEbSlLEe/1Krvk+LrCoVrfnI58TJ6rDwNAnQLJ+Xd5U=;
        b=E6km6C8KAseaY8cxTUCg0iIAZNPHgPg8Ce3oouzZpVAdT8C9UcQWi47QYIRTENyBq6
         34ODBaWl2b+2hB6P9NxseV5J1IPZ5OyexEkfUBAOBJmwpBf6aA+MXgw9cKnYzTmpVx5R
         ZWqU+gjAoVDxhVgPupl0ybegPdKHWYh+G2KylRUful8XB/TIVJGSXuUFUzM3f+m8D3Qq
         GaQMHLtD4037jvVha6+/VkX14O9R9taiqzWGUnJzgskUsui9ztTqeGnf0oqpThlNahYa
         34xEte3+hqe1PAurvd1sRX8aoBJxZsGrM3OfN7Z/OpoD6d9sCWfkU+NDNUaeeznw3q5a
         m1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HEbSlLEe/1Krvk+LrCoVrfnI58TJ6rDwNAnQLJ+Xd5U=;
        b=IiuK5iZTEJ/gufOmQdvzt/vcKhKJqWmu9NkBaZU7Byc5QOjzaGlvWCybWQ7++tSK1B
         cmYv9KO5T7dLUuKnowZiN+F5szk61/uVnXeGYkRC1q8d30t2nSoZSdLiNkjTObp5hrKt
         tiUl80WkFHJc0w5+wWDpGfiH5i+47BwQ2ajbpuKXaItGqT08Js+pROec9r2/E6YK1oxM
         5HT/RXwbpFMfhzcAfrJV6ak1FbiKw7jIRz3khrh58nCVwQfaVCCle2KAIED5+SX6ep0G
         ukoy+VD3CtB66GX1xc/0xyTUur3UwqFTjFfs9OQkmG6+sBBadidFVLT19b5qHNmAeYKy
         LEyQ==
X-Gm-Message-State: AJIora9R6k9Q+VDJdyj8m571GpRsuZ1rc7Tz9uD6b0hF1XSk9gczkfzU
        tEAFZT9zk7wOEqbcAimHzgbv0bRUEW+jBQ==
X-Google-Smtp-Source: AGRyM1sCtr+IuJAZU8na9BADRfkUS7Hlf1oYX2SIUQoe2nfXo3AY011D7K+CgBk0b9y7eTVUx6LY1uvGQ1GFBQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:4091:b0:16b:e3d5:b2da with SMTP
 id z17-20020a170903409100b0016be3d5b2damr24053021plc.58.1657223726482; Thu,
 07 Jul 2022 12:55:26 -0700 (PDT)
Date:   Thu, 07 Jul 2022 12:55:18 -0700
In-Reply-To: <Yr5OTq7s2qxxqsiY@nand.local>
Message-Id: <kl6lh73svgt5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com> <a1323d963f917df661a8701c305d84e781a8f550.1656612839.git.gitgitgadget@gmail.com>
 <Yr5OTq7s2qxxqsiY@nand.local>
Subject: Re: [PATCH v6 5/5] setup.c: create `discovery.bare`
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 30, 2022 at 06:13:59PM +0000, Glen Choo via GitGitGadget wrote:
>> [1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
>> [2]: https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com
>>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  Documentation/config.txt           |  2 ++
>>  Documentation/config/discovery.txt | 23 ++++++++++++
>>  setup.c                            | 57 +++++++++++++++++++++++++++++-
>>  t/t0035-discovery-bare.sh          | 52 +++++++++++++++++++++++++++
>>  4 files changed, 133 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/config/discovery.txt
>>  create mode 100755 t/t0035-discovery-bare.sh
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e284b042f22..9a5e1329772 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -409,6 +409,8 @@ include::config/diff.txt[]
>>
>>  include::config/difftool.txt[]
>>
>> +include::config/discovery.txt[]
>> +
>>  include::config/extensions.txt[]
>>
>>  include::config/fastimport.txt[]
>> diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
>> new file mode 100644
>> index 00000000000..bbcf89bb0b5
>> --- /dev/null
>> +++ b/Documentation/config/discovery.txt
>> @@ -0,0 +1,23 @@
>> +discovery.bare::
>> +	Specifies whether Git will work with a bare repository that it
>> +	found during repository discovery. If the repository is
>
> Is it clear from the context what "discovery" means here? It's probably
> easier to describe what it isn't, which you kind of do in the next
> sentence. But it may be clearer to say something like:
>
>     Specifies whether Git will recognize bare repositories that aren't
>     specified via the top-level `--git-dir` command-line option, or the
>     `GIT_DIR` environment variable (see linkgit:git[1]).

Hm that's a good point and the suggestion is very well-worded. In
addition to what you have, I think we should make reference to
"discovery" _somewhere_ in here since the option is named
`discovery.bare`, and this seems like a good teaching opportunity.

>> +This defaults to `always`, but this default may change in the future.
>
> I think the default being subject to change is par for the course. It's
> probably easy enough to just say "Defaults to 'always'" and leave it at
> that.

Makes sense.

>> +static enum discovery_bare_allowed get_discovery_bare(void)
>> +{
>> +	enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
>> +	git_protected_config(discovery_bare_cb, &result);
>> +	return result;
>> +}
>> +
>> +static const char *discovery_bare_allowed_to_string(
>> +	enum discovery_bare_allowed discovery_bare_allowed)
>> +{
>> +	switch (discovery_bare_allowed) {
>> +	case DISCOVERY_BARE_NEVER:
>> +		return "never";
>> +	case DISCOVERY_BARE_ALWAYS:
>> +		return "always";
>
>> +	default:
>> +		BUG("invalid discovery_bare_allowed %d",
>> +		    discovery_bare_allowed);
>
> Should we have a default case here since the case arms above are
> exhaustive?

Ah, this "default:" was suggested by Stolee in
https://lore.kernel.org/git/7b37f3b7-58c5-1ac5-46eb-d995dc3cc33b@github.com

  This case should be a "default:" in case somehow an arbitrary integer
  value was placed in the variable. [...]

I'm not sure where we stand on this kind of defensiveness. It's not
really necessary, but I suppose having a "default:" won't hurt here,
especially if it BUG()-s instead of silently passing.

>> +	}
>> +	return NULL;
>> +}
>> +
>>  enum discovery_result {
>>  	GIT_DIR_NONE = 0,
>>  	GIT_DIR_EXPLICIT,
>> @@ -1151,7 +1195,8 @@ enum discovery_result {
>>  	GIT_DIR_HIT_CEILING = -1,
>>  	GIT_DIR_HIT_MOUNT_POINT = -2,
>>  	GIT_DIR_INVALID_GITFILE = -3,
>> -	GIT_DIR_INVALID_OWNERSHIP = -4
>> +	GIT_DIR_INVALID_OWNERSHIP = -4,
>> +	GIT_DIR_DISALLOWED_BARE = -5,
>>  };
>>
>>  /*
>> @@ -1248,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>>  		}
>>
>>  		if (is_git_directory(dir->buf)) {
>> +			if (!get_discovery_bare())
>
> Relying on NEVER being the zero value here seems fragile to me. Should
> we check that `if (get_discovery_bare() == DISCOVERY_BARE_NEVER)` to be
> more explicit here?

This was also originally suggested by Stolee in 
https://lore.kernel.org/git/7b37f3b7-58c5-1ac5-46eb-d995dc3cc33b@github.com

  With (some changes to return the enum), we can [...] let the caller
  treat the response as a simple boolean.

but.. your suggestion does seem less fragile. It won't really matter
when we add a third enum and replace the "if" with a "switch", but it
does matter if we ever muck around with the integer values of
DISCOVER_BARE_*.

>> +				return GIT_DIR_DISALLOWED_BARE;
>>  			if (!ensure_valid_ownership(dir->buf))
>>  				return GIT_DIR_INVALID_OWNERSHIP;
>>  			strbuf_addstr(gitdir, ".");
>> @@ -1394,6 +1441,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>>  		}
>>  		*nongit_ok = 1;
>>  		break;
>> +	case GIT_DIR_DISALLOWED_BARE:
>> +		if (!nongit_ok) {
>> +			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
>> +			    dir.buf,
>> +			    discovery_bare_allowed_to_string(get_discovery_bare()));
>> +		}
>> +		*nongit_ok = 1;
>> +		break;
>>  	case GIT_DIR_NONE:
>>  		/*
>>  		 * As a safeguard against setup_git_directory_gently_1 returning
>
> Thanks,
> Taylor
