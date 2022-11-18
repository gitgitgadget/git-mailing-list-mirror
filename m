Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA63C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 16:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiKRQgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 11:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiKRQgp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 11:36:45 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1D5CD31
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 08:36:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y13so5358688pfp.7
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ACISBODkz9PtVMOKlvKWPzl+oKsT44jB0/ygo90Kqs=;
        b=DHxSCAORJv0C+yUQLQ7Ly6dWU8TFWp8ZgBR88hu8kXgL9UC+Nwh4jpjsXOYaSaqoEb
         tl9ew58S2habqVf8WIBbeoltCyvHtMj3iT0ZlFvjYEpzX1GDEp441PimPDAeStHAJb7X
         3hpafhcczYNqpg4DQcEtVNczctKcbgAQJ3nomFkrvBccI+NjYv1BGXFLusOifCu1yJz4
         odGKQRmjwVfiXbQxJ7/dzeHqmvET8eqRZ15Ejt3v7/vc8DBVU/9mUpiqyKMF+fc6/fqW
         rYl1kb0rW8rwRA9WpJHqwzQ2o4A1UL8cTGO8H4jowriYIP8V08HXdYPYrv4bVlhqmoR6
         NQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ACISBODkz9PtVMOKlvKWPzl+oKsT44jB0/ygo90Kqs=;
        b=RMKQkKK2Va3wzVhRJgsJHbgo9XNEn+YS9foIq6zQSZAffEFWWkD9n2rlHqQW7nGxpw
         H8seMXuIjZD8al9tVyhbTYqvkBJjiciI+XZMIbZkhdl+B+txXmW3WSbzQzPin9DhWP99
         DLV71ZCxWQCcaxb0UCWVCKNE0Z5fQ6hlB1ZcluyfE5+GcYaO9hz4EedCkJnI7f5GeWRf
         +ss+AUcr9G7Jquqxdmyeu4n3uROj7gQ1pYtnoZKu7WW21YvBfI0CISanFce/F2kxbVuE
         hCXOb997TBibe3l5CYix2Jl1fYgiEcUK7h2tPp+Pl8VRdqSd0ls54k3lcaLPvG3t6ed6
         BRaA==
X-Gm-Message-State: ANoB5pnF5hnNuCmWaurjtIe8NZ0rcfrXEihIhE6EkMz/v/b1XZGlcbbX
        vIugkiBT0pMwVYGxBv8GkrHr
X-Google-Smtp-Source: AA0mqf75DXOo49X0sQR6LkT62o/OegJek57lWs0DT2CYdlZiZwkjwNkr88tW7RGSBfuBiNesQkTM4Q==
X-Received: by 2002:a63:5762:0:b0:45f:97e8:d8a7 with SMTP id h34-20020a635762000000b0045f97e8d8a7mr7245330pgm.426.1668789404050;
        Fri, 18 Nov 2022 08:36:44 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b00176b84eb29asm3914030pls.301.2022.11.18.08.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 08:36:43 -0800 (PST)
Message-ID: <ddc1b100-98f3-7ddf-aa2b-af080cb40443@github.com>
Date:   Fri, 18 Nov 2022 08:36:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
 <221118.864juwhkcc.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <221118.864juwhkcc.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Nov 17 2022, Rubén Justo wrote:
>> Whenever we copy or move (forced or not) we must make sure that there is
>> no residual configuration that will be, probably erroneously, inherited
>> by the new branch.  To avoid confusions, clear any branch configuration
>> before setting the configuration from the copied or moved branch.
> 
> So, whatever tea leaves we read into the history, or whether this was a
> good or bad design in the first place, I think we should probably lean
> towards not having this be a bug fix, but a new feature. Both modes are
> clearly easy to support.
> 
> And then document it in terms of some new switch being the equivalent to
> --remove-section followed by a rename, the existing thing a rename etc.

I've noticed a bit of a pattern on the mailing list where, if the desired
user experience is unclear, the suggestion is "add an option! then users can
choose for themselves." But then, at the same time, we'll complain about
option bloat (as you [1] and Taylor [2] did on another recent series).

I don't see a compelling enough reason to introduce an option variant here.
Could I imagine a user wanting such a feature? Yes. But it also isn't clear
what users would practically use. I think a more conservative approach would
be appropriate: in this case, come to an agreement on a sane default (i.e.,
should we preserve the source's, or the destination's, tracking config?),
then wait for feedback to indicate whether there's a desire for an
alternative to that default.

[1] https://lore.kernel.org/git/221117.86k03tiudl.gmgdl@evledraar.gmail.com/
[2] https://lore.kernel.org/git/Y3ave2+kEwLTvtE6@nand.local/

> 
>> @@ -583,12 +583,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>  
>>  	strbuf_release(&logmsg);
>>  
>> -	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>> -	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>> -	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
>> -		die(_("Branch is renamed, but update of config-file failed"));
>> -	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
>> -		die(_("Branch is copied, but update of config-file failed"));
>> +	if (strcmp(interpreted_oldname, interpreted_newname)) {
>> +		strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>> +		strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>> +
>> +		delete_branch_config(interpreted_newname);
>> +
>> +		if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
>> +			die(_("Branch is renamed, but update of config-file failed"));
>> +		if (copy && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
>> +			die(_("Branch is copied, but update of config-file failed"));
> 
> Aside from any question of a hypothetical "should", your implementation
> is running head-first into a major caveat in our config API.
> 
> Which is that we don't have transactions or rollbacks, and we don't even
> carry a lock forward for all of these.
> 
> So, there's crappy edge cases in the old implementation as you've found,
> but at least it mostly failed-safe.
> 
> But here we'll delete_branch_config(), then release the lock, and then
> try to rename the new branch to that location, which might fail.
> 
> So, we'll be left with no config for the thing we tried to clobber, nor
> the new config.

This is a good point, so to add to it: I think a fairly unobtrusive solution
would be to move the config deletion after the rename is 100% complete.

