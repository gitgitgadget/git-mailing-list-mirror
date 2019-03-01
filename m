Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C021A20248
	for <e@80x24.org>; Fri,  1 Mar 2019 11:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfCALVF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 06:21:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfCALVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 06:21:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so11872984wmg.4
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4810DoAvJMJDbtJQn6bAyZwV6mZJpGh5HOGTSanhO40=;
        b=YfNSj+yte6z7d5e8yyl0Pb1RRP4GWwGo25BS/rpO1/TLBpUlXnj7hL1wgMQURIdXaT
         SBwbmh+lPjC8oTeHTV33jiw2fxpi+hMUunKRT2vIxt2BF2wAE0EjnJuIK7aa1LQQsLSJ
         uwQawKTZP61w0kIwowJiUKElEwqnXotE1zv8jDqmrfDG5lwQnzISHiAoN2bsLUVfbt9Z
         Dz+zW0mz27RxVR1+nL1Oef0oLA8Ffi62mVYlGLhvRBhgj4YHbHdZiQqvW8mRZSYkhGop
         9D1XtU5w7bMBds4Tv/Btf44OWjg+ikhFbtkG8wUe1XEzdMFX12trcr8PqcCZJ7WhxwwA
         CeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4810DoAvJMJDbtJQn6bAyZwV6mZJpGh5HOGTSanhO40=;
        b=WjjIk1zTpCVP8MX3V9RTk/9BUcF+MdOJg0UPeWkq0qHDjKOE302zCPJOIF4QQ9O1OE
         BFPU1qfVzg8FyxDEy98NlGJlXmpNYwjFEDRljDGjySe3qxUHgjPfJaWckaJWtrsjx2gw
         kcFtZASsYWesyHFjTaf9s03gW3z7ACQbMqOjNp+u8+kM36yuSl+1gRtV+LTnP4NrCrpC
         YokR+TPtk8vDpdppVLN0dMUAfBPMwSVd1d9PzUPsq8jMKEDPfv1GbudF1b2/wKVcgPyv
         uSaaOBzcuw5ZEpD90UG8GtbefJ9O5fgZMZJw969bKsG9kc1Sh2cLlJnuu6xoP+xrtOON
         7lEQ==
X-Gm-Message-State: AHQUAuYODXjHB3Tk3DHWr9NpMv6JKbCzfVLX/EuYZ53Yd5PdbQ6ybT8J
        vVAaskC6zntn5u1dz4IBPxw=
X-Google-Smtp-Source: AHgI3IaWGFqvz8u5OZTfIpTTMOKabytCwARS49ekLn/ROuu5p9DQIBvpMiseQGa6ggjAxJK/C7GANg==
X-Received: by 2002:a1c:a809:: with SMTP id r9mr2829355wme.34.1551439261866;
        Fri, 01 Mar 2019 03:21:01 -0800 (PST)
Received: from [192.168.1.5] ([31.223.156.168])
        by smtp.gmail.com with ESMTPSA id v196sm11651632wmf.15.2019.03.01.03.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 03:21:01 -0800 (PST)
Subject: Re: [PATCH v5 04/10] add-interactive.c: implement list_and_choose
To:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
 <pull.103.v5.git.gitgitgadget@gmail.com>
 <a97b29d2741e0e5ae8cf45b1c7cafc56afaa66ef.1550662887.git.gitgitgadget@gmail.com>
 <xmqqd0njpkd5.fsf@gitster-ct.c.googlers.com>
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
Message-ID: <25f71e47-acad-e985-4f3f-ecde77f883d6@gmail.com>
Date:   Fri, 1 Mar 2019 12:20:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqd0njpkd5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22-Feb-19 10:46 PM, Junio C Hamano wrote:
> "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +#define HEADER_INDENT "      "
>> +
>>   enum collection_phase {
>>   	WORKTREE,
>>   	INDEX
>> @@ -27,6 +29,61 @@ struct collection_status {
>>   	struct hashmap file_map;
>>   };
>>   
>> +struct list_and_choose_options {
>> +	int column_n;
>> +	unsigned singleton:1;
>> +	unsigned list_flat:1;
>> +	unsigned list_only:1;
>> +	unsigned list_only_file_names:1;
>> +	unsigned immediate:1;
>> +	char *header;
>> +	const char *prompt;
> Makes a reader wonder if "header" can also be const (not to be taken
> as a suggestion to bend backwards to make it so).
>
>> +	void (*on_eof_fn)(void);
>> +};
>> +
>> +struct choice {
>> +	struct hashmap_entry e;
>> +	char type;
> If this is for choosing among the member of union, possible value(s)
> for the type member and which value corresponds to which union
> member must be documented somewhere, perhaps as a comment around
> here.
>
>> +	union {
>> +		void (*command_fn)(void);
>> +		struct {
>> +			struct {
>> +				uintmax_t added, deleted;
>> +			} index, worktree;
>> +		} file;
>> +	} u;
>> +	size_t prefix_length;
>> +	const char *name;
>> +};
>> +
>> +struct choices {
>> +	struct choice **choices;
> In general, do not name an array in plural.  An exception is when
> the code mostly refers to the array as a whole.
>
> When most accesses are to individual elements, then it would be a
> big win to be able to see choice[2] and pronounce it "the second
> choice" (you do not say "the second choices").
>
>> +	size_t alloc, nr;
>> +};
>> +#define CHOICES_INIT { NULL, 0, 0 }
>> +
>> +static int use_color = -1;
>> +enum color_add_i {
>> +	COLOR_PROMPT,
>> +	COLOR_HEADER,
>> +	COLOR_HELP,
>> +	COLOR_ERROR
>> +};
>> +
>> +static char colors[][COLOR_MAXLEN] = {
> Do not be overly selfish to assume that this will stay to be the
> only color pallette in this file.  If this is the color palette for
> list_and_choose, then have it in its name, e.g. list_and_choose_color[]
> or something like that.
>
>> +	GIT_COLOR_BOLD_BLUE, /* Prompt */
>> +	GIT_COLOR_BOLD,      /* Header */
>> +	GIT_COLOR_BOLD_RED,  /* Help */
>> +	GIT_COLOR_RESET      /* Reset */
>> +};
> Is the above list of values and comments correct?
>
> Doesn't each member of enum correspond to each element in
> list_and_choose_color[][COLOR_MAXLEN] array?  It does not exactly
> match my intuition to have help text in red and error messages in
> plain color.


I noticed I didn't add colors in corresponding commits, but list is 
correct -- later
on in patch series there is

GIT_COLOR_BOLD_RED, /* Error*/

added so that error messages are shown in red.


Help text is also in red following up what is happening in 
git-add--interactive.perl.

>> @@ -186,3 +243,73 @@ static struct collection_status *list_modified(struct repository *r, const char
>>   	free(files);
>>   	return s;
>>   }
>> +
>> +static struct choices *list_and_choose(struct choices *data,
>> +				       struct list_and_choose_options *opts)
>> +{
>> +	if (!data)
>> +		return NULL;
>> +
>> +	while (1) {
>> +		int last_lf = 0;
>> +
>> +		if (opts->header) {
>> +			const char *header_color = get_color(COLOR_HEADER);
>> +			if (!opts->list_flat)
>> +				printf(HEADER_INDENT);
> I won't complain if this is sufficient for the application, but the
> above would not allow different level of indentation depending on
> what header is being shown.  It may make sense to get rid of list_flat
> boolean and instead allow a new "const char *header_indent" member
> in the opts structure supplied by the caller.
>
> Don't use printf() when you _know_ you want to show a simple string
> without any % interpolation.  fputs(HEADER_INDENT, stdout) would suffice.
>
>> +			color_fprintf_ln(stdout, header_color, "%s", opts->header);
>> +		}
>> +
>> +		for (int i = 0; i < data->nr; i++) {
> We do not say "for (int i" (see a previous review).
>
>> +			struct choice *c = data->choices[i];
>> +			char *print;
>> +			const char *modified_fmt = _("%12s %12s %s");
>> +			char worktree_changes[50];
>> +			char index_changes[50];
>> +			char print_buf[100];
> It appears that many of these variables are only needed inside "we
> are showing 'f' and not just names" block.  Can their scope be
> narrowed?


Yes, I will change this.


>
>> +			print = (char *)c->name;
> Yuck.  Stuff c->name into print_buf[] instead and get rid of "print"
> pointer.
>
>> +			if ((data->choices[i]->type == 'f') && (!opts->list_only_file_names)) {
>> +				uintmax_t worktree_added = c->u.file.worktree.added;
>> +				uintmax_t worktree_deleted = c->u.file.worktree.deleted;
>> +				uintmax_t index_added = c->u.file.index.added;
>> +				uintmax_t index_deleted = c->u.file.index.deleted;
>> +
>> +				if (worktree_added || worktree_deleted)
>> +					snprintf(worktree_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX,
>> +						 worktree_added, worktree_deleted);
>> +				else
>> +					snprintf(worktree_changes, 50, "%s", _("nothing"));
>> +				if (index_added || index_deleted)
>> +					snprintf(index_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX,
>> +						 index_added, index_deleted);
>> +				else
>> +					snprintf(index_changes, 50, "%s", _("unchanged"));
>> +
>> +				snprintf(print_buf, 100, modified_fmt, index_changes,
>> +					 worktree_changes, print);
> All of the above look overly repetitious; a helper function that
> takes a pointer to "struct { uintmax_t a, d; }" and populates
> changes[] buffer would cut them down by half, but other than that
> I do not see a room for drastic improvement here X-<.
>
> Oh, it would greatly help to use two strbuf for wt/ix_changes that
> are defined outside the loop that is strbuf_reset() after each
> iteration and use things like strbuf_addf().
>
>> +				print = xmalloc(strlen(print_buf) + 1);
>> +				snprintf(print, 100, "%s", print_buf);
> Likewise.
>
>> +			}
>> +
>> +			printf(" %2d: %s", i + 1, print);
>> +			if ((opts->list_flat) && ((i + 1) % (opts->column_n))) {
>> +				printf("\t");
>> +				last_lf = 0;
>> +			}
>> +			else {
>> +				printf("\n");
>> +				last_lf = 1;
>> +			}
>> +
>> +		}
>> +
>> +		if (!last_lf)
>> +			printf("\n");
>> +
>> +		return NULL;
>> +	}
>> +}
> This obviously only lists but does not let you choose at this step
> in the series, but that is OK.
>
> But I see a deeper problem with the design of this helper.  The
> things this helper can list is quite limited.
>
> The original was designed so that the shown strings are prepared by
> the caller and this helper is solely responsible for showing the
> choices, giving prompt, and accepting choice (in various abbreviated
> forms), all _WITHOUT_ having to know the meaning of what is in the
> list.  It gave us a much better separation of labor and
> responsibility between the caller and the callee, I would think.
>

Thanks for pointing this out. I talked to my mentor and I'm now working on
making list_and_choose more "type-independent".

I didn't reply to all suggestions in this message, but I did apply them 
in the code.

>
