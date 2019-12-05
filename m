Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AFAC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAA5206DB
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roDatJzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfLEPk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:40:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37741 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 10:40:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so3941075qtk.4
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hXztEI30rWQHHtxHwDfyEdX0wU4LYUj4YCb8pK7ARZo=;
        b=roDatJzg0YoscISkqfl2iFd7mqO06ict7I7pLNS0xJC8QDxC+qsdaZ3Nv/2YvD0Zw5
         KgncIylZZpgU46SC78C/eGEfK9ItudUm7A4Btxxd1eqNOO3lKhLS/pM3ncrNSDA3GfAo
         1SXnjhmOmtOHxA+ZdCWp1UQ/8DyqR2qRRNlkL/TW4CU0O+9JRj+SXhxcrLY/422ACTeZ
         JzZz0al+aHIU37izWxJbgx5HYDMS5+Jbxn/v3XCze/+ST5kkmh1qfu92sfZ5sZxidCEq
         N9P7TYp5R+PBhsl/cBKY+Nsa22+3bb+mOdVP92ReF+6+9v66HCOXu59YAn9pi8tacD9R
         2jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hXztEI30rWQHHtxHwDfyEdX0wU4LYUj4YCb8pK7ARZo=;
        b=DG1k2on4ZvqbJ+vKVFYGQZV2EtR3i8vZ5vfzBGlb+DTJ1GOlhI+M3+rMr7I2Dx7Hd6
         kZ3qCoTY+rqRxoHvG5Q7HcQQBMiNQROaqVouZR9g2QxKlRpKbIW0V4cSMcVcP9YXlx9y
         DzTUJQYfowXMte+Zb6QZTpGEUFILFDe3/kwSa0KDePAeVFP/l2yq+MpWyGvPSeHWljiL
         mIKNE3umFYv3QIOTE8GgZpyMhJGcc0A+LhdCUqcXDlp5zUBOJueCEzoubEKlxDEWVQ9f
         Iod9m41g22vS1ZRIkcGe1EeP7LAKhA4B5vQ6/9wKYIlFgU1wK3E9l8axcY8AqDBrQCcl
         mZDg==
X-Gm-Message-State: APjAAAX8M4LPG3B4yxIjSucSLZyZrdZYUI80gep/xThpr+pLiWjCNWv/
        A1asa4T6FLj1kF6SOIqA9rG78ZIfPBY=
X-Google-Smtp-Source: APXvYqyrJ1CVz/5Bf3QLAX81QwL41HEFYK18DZkrecQqmkiCV2SZ0iGwmwt6aPqTs3EA2A+QpsRw4Q==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr8261498qtv.137.1575560457377;
        Thu, 05 Dec 2019 07:40:57 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id e6sm4899757qkg.89.2019.12.05.07.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 07:40:56 -0800 (PST)
Subject: Re: [PATCH v4 09/11] git-p4: Add usability enhancements
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <4fc49313f0d68a913ad19085ddb337ac4c18d0fe.1575498578.git.gitgitgadget@gmail.com>
 <xmqqfthy27hy.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <652370f7-d1c5-a78a-aa5f-6e0c3219cd36@gmail.com>
Date:   Thu, 5 Dec 2019 10:40:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqfthy27hy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 9:04 AM, Junio C Hamano wrote:
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ben Keene <seraphire@gmail.com>
>>
>> Issue: when prompting the user with raw_input, the tests are not forgiving of user input.  For example, on the first query asks for a yes/no response. If the user enters the full word "yes" or "no" the test will fail. Additionally, offer the suggestion of setting git-p4.attemptRCSCleanup when applying a commit fails because of RCS keywords. Both of these changes are usability enhancement suggestions.
> Drop "Issue: " and upcase "when" that follows.  The rest of the
> paragraph reads a lot better without it as a human friendly
> description.
>
> "are usability enhancement suggestions"???  Leaves readers wonder
> who suggested them, or you are suggesting but are willing the change
> to be dropped, or what.  Be a bit more assertive if you want to say
> that you believe these two would improve usability.
Thank you and I reworked my submissions. I'm moving them to a separate 
PR and will split the commit into 3 separate commits.
>> Change the code prompting the user for input to sanitize the user input before checking the response by asking the response as a lower case string, trimming leading/trailing spaces, and returning the first character.
>>
>> Change the applyCommit() method that when applying a commit fails becasue of the P4 RCS Keywords, the user should consider setting git-p4.attemptRCSCleanup.
> s/becasue/because/;
>
> I have a feeling that these two may be worth doing but are totally
> separate issues, deserving two separate commits.  Is there a good
> reason why these two must go hand-in-hand?
>
Good idea, and I split them out.
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit 1fab571664f5b6ad4ef321199f52615a32a9f8c7)
>> ---
>>   git-p4.py | 31 ++++++++++++++++++++++++++-----
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index f7c0ef0c53..f13e4645a3 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1909,7 +1909,8 @@ def edit_template(self, template_file):
>>               return True
>>   
>>           while True:
>> -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
>> +            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ").lower() \
>> +                .strip()[0]
> You could have saved the patch by doing
>
> 	+	.lower().strip()[0]
>
> instead, no?
>
> I wonder if it would be better to write a thin wrapper around raw_input()
> that does the "downcase and take the first meaningful letter" thing
> for you and call it prompt() or something like that.
I created a new function prompt() as you suggested.
>> @@ -4327,7 +4343,12 @@ def main():
>>                                      description = cmd.description,
>>                                      formatter = HelpFormatter())
>>   
>> -    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
>> +    try:
>> +        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
>> +    except:
>> +        parser.print_help()
>> +        raise
>> +
> This change may be a good idea to give help text when the command
> line parsing fails, but a good change deserves to be explained.  I
> do not think I saw any mention of it in the proposed log message,
> though.

Yes, you're right.  I split this out into a separate commit as well and 
gave it a place or prominence.

>>       global verbose
>>       verbose = cmd.verbose
>>       if cmd.needsGit:
