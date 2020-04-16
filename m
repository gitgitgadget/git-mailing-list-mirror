Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACFC2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7818221D7E
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj/ZQ/4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441758AbgDPPCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441756AbgDPPCo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 11:02:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43547C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:02:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so5248442wrx.4
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwxQPulFGsBW3so1B6CUiGls7fe9MROvdp88LW9sYww=;
        b=lj/ZQ/4/HAzu3i6nqXRDmqKnNNVWpeTF87DHY+ik/04oaFCVqt6rlNulffut1OV7aH
         AB9+wnfGEGJCKolSbUS50I+6lZUxuUT7bbj7ar4JnttIRGI5Sy+7hw16zGzPmyN5Z+D5
         SGKQwtviwgsqn/0UtNY6KUrkoN5srZ156FVV/j+eRWAWotXe+uyynObeKWSsUrPsuQ68
         xOomJcFx7hn813fWgtVSAaGvzHIcXN314AtbrcqNYWw7gDXVKuBmUQ6BxD/wrN1bqd8J
         Qixg0sQmAJkeKHq09W0MyqOh+ACrDECGOnLv+SRjq3vPXvlDKrOWetYC6cv4W1BMQ4Qg
         hpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gwxQPulFGsBW3so1B6CUiGls7fe9MROvdp88LW9sYww=;
        b=apKZhQ6MGxzPpMMHHPqbrlNwy8AioKsd0vmo4GD4xfrZEVsqNsADP9/zb4LFZZrQFd
         rC2TjrmTwCTovqBxNCwyQrOF8vrr+SVBnfx5j7hmoDGQdTkRzqWW833dae8rUf0KweLR
         UEUn8JiHqMD9rqi75WPVxTO0hiFQgymyI+KomvDTVb9IoC3NPLrScZwlkwZbzsl/1j7u
         hj0xzdzdBi1HBX3vBJ5dcy5/Abp/WePWQQKHD5pNBRSGeuKLQDr4h4CNSvy2qNbF2JLq
         9HsGTCYmA1pI1PA9R46Bextpf1axW+m32DXf0CJqEoMDLq2EG1we1eq5kU3QHDTfMCKy
         qUsA==
X-Gm-Message-State: AGi0PuY48LsdbKOjo9WK6LmwOGCkCsIbIYPgB4NJD32FtZcMtAoSNg9j
        JBypaaX0hedjgMy6X0Q0mbc=
X-Google-Smtp-Source: APiQypLtmgWpZ58JHq4Vq9bDJLFdj3U762M7y4wwpIrIFjF6YlTxLAJOu20kYnaWOcQ4/W6OyaBcLA==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr33874267wrr.131.1587049362901;
        Thu, 16 Apr 2020 08:02:42 -0700 (PDT)
Received: from [192.168.1.240] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id p7sm28249042wrf.31.2020.04.16.08.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:02:42 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] sequencer: do_commit: print the change summary ala
 git-am
To:     Leah Neukirchen <leah@vuxu.org>, git@vger.kernel.org
References: <87mu7blg9w.fsf@vuxu.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <77013d6c-6068-acd8-09be-3da8fc9904ea@gmail.com>
Date:   Thu, 16 Apr 2020 16:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87mu7blg9w.fsf@vuxu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Leah

Thanks for the patch

On 16/04/2020 13:39, Leah Neukirchen wrote:
> 
> This makes the output of "git pull --rebase" look as if using the
> apply backend.
>
> Signed-off-by: Leah Neukirchen <leah@vuxu.org>
> ---
> I noticed that the new "merge" rebase backend does not print lines ala
> "Applying: reticulate the splines" anymore.  I found these useful when
> using "git pull --rebase", as one easily saw which unpushed patches
> were in the tree.  (Also, eliminated patches were not printed anymore,
> but that is a special thing about our workflow, where many committers
> can do exactly the same trivial patches often.)
> 
> I found do_commit to be the best place to put this, but I'm not
> super familiar with the Git code base; perhaps this also prints
> in other invocations where it rather shouldn't.

I think it also changes the output of rebase -i/-r, cherry-pick and 
revert. Fixing the latter two is easy, it will be trickier to fix the 
former. Rebase -i/-r/-m already print 'Rebasing (n/m)' as they apply 
each patch and reuses the same line if --verbose is not given to save 
terminal space where they are picking a large number of commits.

I can see why you want this output when rebasing after pulling, I'm not 
sure we necessarily want to change the output of rebase -i/-m/-r though. 
Maybe we can add a member to struct replay_opts that is set by pull and 
rebase --apply or maybe we should print the commit subject when 
--verbose is set. I'm not really sure at the moment - I've cc'd Elijah 
and dscho to see if they have any thoughts

> linelen is taken from builtin/am.c.

A minor point - the sequencer uses the subject as given by 'log 
--pretty=%s' when creating the todo list and I think that is probably 
what we should be printing (both here and for am). This is subtly 
different from using linelen() as --pretty=%s unwraps all the lines 
before the first empty line of the commit message so

   line one
   line two

   commit message body

would appear as 'line one line two' whereas linelen() just gives 'line one'

Best Wishes

Phillip


>   sequencer.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 6fd2674632..5e315eda1c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1442,6 +1442,14 @@ static int write_rebase_head(struct object_id *oid)
>   	return 0;
>   }
>   
> +/**
> + * Returns the length of the first line of msg.
> + */
> +static int linelen(const char *msg)
> +{
> +        return strchrnul(msg, '\n') - msg;
> +}
> +
>   static int do_commit(struct repository *r,
>   		     const char *msg_file, const char *author,
>   		     struct replay_opts *opts, unsigned int flags,
> @@ -1458,6 +1466,10 @@ static int do_commit(struct repository *r,
>   					     "from '%s'"),
>   					   msg_file);
>   
> +		if (!opts->quiet)
> +			fprintf_ln(stdout, _("Applying: %.*s"),
> +				linelen(sb.buf), sb.buf);
> +
>   		res = try_to_commit(r, msg_file ? &sb : NULL,
>   				    author, opts, flags, &oid);
>   		strbuf_release(&sb);
> 
