Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76601F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbcHOTDb (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 15:03:31 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35802 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbcHOTDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 15:03:30 -0400
Received: by mail-io0-f173.google.com with SMTP id m101so87578700ioi.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 12:03:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mMCEVs+jSU+TQjIpGBRll2o7z5O+GQKhAFhkT4hiL1I=;
        b=jGp5mX1FS2y+Dgcsjhcv14igm9ifNYqAfga+4WrYB8lRDNNkP4is+n1qZO8BMz0ST/
         7oLO/al4uN2LJJe5L4c9NMTwT8aG/9g88WesMrjhv7RY+aaX511QcZuQLOF0Upi1WMTZ
         rHzDfBuwfZvQafNu0jXsYDO5M35n4LKbxq0C70CNCmebXJ+RSb8JyC+Id/7RsAm6otlC
         M8/4FDQhGre4AqGtuChWwrikTQjj6lbIhTczAT1QcP0uN0GUNP5m6idKfk6qlCyiObAU
         /WPf+IQAdvatxPAzfcYiq5gg/snEpmYfgPyX9/xiuRRQsA4dL599MjsH7I55dfkP5wzb
         Wb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mMCEVs+jSU+TQjIpGBRll2o7z5O+GQKhAFhkT4hiL1I=;
        b=Xu3gICg7WIO7rzdm13yPXNf/eh05mMLy5IrTHKijGxsaLgwmfr6X2HzWH9+0Hr6n8L
         BniChKzPkY48XJpR7EB8E2aB9nWAwkVpk5Y0SWoRU93Ke+Z1dp3S3clTetTmbZgOp5fk
         4+80J+vzMx56fq2r6Noti2cw6lszZK5E2+VngLrXMbULoKNhwi/DX6x59DNBp8ggSRnS
         nUy11tr/mA3rj0y0Uj01xCLAO1fEy61KaDOwpU5xHH3IdQBjXe38D0JH1Le7Jlf96OOd
         zup1j2fYE4NAoadm0WxdSShBtuyP0UEidCmakDZy44NfkBiJtn/It1dswPf0OplrKoCP
         jjxA==
X-Gm-Message-State: AEkoouvLfEWLhkDoiTS0UoopP3PZk+QTFyVBX2W7nVQR96j2Ezvzv5472NWRM3Y/TCdbJ6T9DBBMmxyocMYfBAcm
X-Received: by 10.107.178.129 with SMTP id b123mr35423533iof.83.1471287803077;
 Mon, 15 Aug 2016 12:03:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 15 Aug 2016 12:03:22 -0700 (PDT)
In-Reply-To: <xmqqa8ghvd3j.fsf@gitster.mtv.corp.google.com>
References: <20160811231405.17318-1-sbeller@google.com> <20160811231405.17318-6-sbeller@google.com>
 <xmqqa8ghvd3j.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 15 Aug 2016 12:03:22 -0700
Message-ID: <CAGZ79kYVh7N-H7iO4E7HydeOzdUfxGTc3sUo8RhCzR33u9gRHw@mail.gmail.com>
Subject: Re: [PATCHv4 5/8] clone: factor out checking for an alternate path
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 3:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +     struct strbuf sb = STRBUF_INIT;
>> +     char *ref_git = compute_alternate_path(item->string, &sb);
>
> Who owns the memory for ref_git?

The caller of compute_alternate_path(..), which makes
add_one_reference faulty as of this patch.

>
>> -     if (!access(mkpath("%s/shallow", ref_git), F_OK))
>> -             die(_("reference repository '%s' is shallow"), item->string);
>> +     if (!ref_git)
>> +             die("%s", sb.buf);
>
> Presumably the second argument to compute_alternate_path() is a
> strbuf to receive the error message?  It is unfortunate that the
> variable used for this purpose is a bland "sb", but perhaps that
> cannot be helped as you would reuse that strbuf for a different
> purpose (i.e. not to store the error message, but to formulate a
> pathname).

Ok. I had an intermediate version with 2 strbufs but for some reason I
decided one is better. We'll have 2 again. (err and sb; sb will have a
smaller scope only in the else part.)

>
>> -     if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
>> -             die(_("reference repository '%s' is grafted"), item->string);
>> +     strbuf_addf(&sb, "%s/objects", ref_git);
>> +     add_to_alternates_file(sb.buf);
>>
>> -     strbuf_addf(&alternate, "%s/objects", ref_git);
>> -     add_to_alternates_file(alternate.buf);
>> -     strbuf_release(&alternate);
>> -     free(ref_git);
>> +     strbuf_release(&sb);
>
> I am wondering about the loss of free() here in the first comment.

fixed in a reroll.

>
>> +/*
>> + * Compute the exact path an alternate is at and returns it. In case of
>> + * error NULL is returned and the human readable error is added to `err`
>> + * `path` may be relative and should point to $GITDIR.
>> + * `err` must not be null.
>> + */
>> +char *compute_alternate_path(const char *path, struct strbuf *err)
>> +{
>> +     char *ref_git = NULL;
>> +     const char *repo, *ref_git_s;
>> +     struct strbuf err_buf = STRBUF_INIT;
>
> Why do you need "err_buf", instead of directly writing the error to
> "err", especially if "err" is not optional?
>
>> + ...
>> +out:
>> +     if (err_buf.len) {

If we were directly writing to err, we would have checked
err.len here. Then you open up a subtle way of saying "dry run"
by giving a non empty error buffer.

I contemplated doing that actually instead of splitting up into 2 functions,
but I considered that bad taste as it would require documentation.

>> +             strbuf_addbuf(err, &err_buf);
>> +             free(ref_git);
>> +             ref_git = NULL;
>> +     }
>> +
>> +     strbuf_release(&err_buf);
>> +     return ref_git;
>> +}
>
> So ref_git is a piece of memory on heap, and the caller is
> responsible for not leaking it.

Correct.
