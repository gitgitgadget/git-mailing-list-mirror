Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C0920705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbcGGVlk (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:41:40 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34076 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbcGGVli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:41:38 -0400
Received: by mail-io0-f179.google.com with SMTP id i186so32107955iof.1
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 14:41:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3E2kBXLMjanrvcyTOQtTpc2TEwXLXER+xVdFY0k3IlA=;
        b=R79OT5XZDJPO3dpAOtaj0hRjh1C9zLHdhVzOU+nWLUHgH0DHUBoZvFKcmsco1C/OoJ
         m90zsTWt5zSQDlFRsTVdwQzFoB15VYU6UPeRbkYldCgxMKwc4Kp+VQaaOmHp3+Iw9fdD
         KwWIOvXBeampQyWoUcUgC+9z5uaksnSgr63XtUD4PqNcE1BXpIhF2YXLR3LUnTj3e04V
         N19YpiiySQ1dQ01kvITVHmV4bh5KrD9iuob+eHRk3AcVYPlrfK58GN88D/L1qsGRDMqW
         t9kTPnbKZ4CO1GeRWml12ktZbCoFZtieIXS42NStnBSPQ6qpyZGEr8s3Pn5rbdhQIBY2
         qzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3E2kBXLMjanrvcyTOQtTpc2TEwXLXER+xVdFY0k3IlA=;
        b=X4SHs0jvF6Y1fTehTbTBAnfDdoMxawiBuXeRLBpWaalwOPI/xm/D52RV8+eHBcV8Zb
         LWH3DsrQsIQuQ1xzWE96lKHFF82fsQv4To0tU0MRAH8kwPsDbvnL1p4K0/uISdcctFta
         1t6bpMTU5N1XqiZzXT+36QLsLfOrwWG8gIkLnZW4HXBa7eYfZZn4EYjzF/6V9lvZBfDe
         lvUCvCkhdabM/Ur0gb79Ebp/drEQaomfCBHHXTDEpNLuEffZX1LEqef3poZ4pv+LcV3j
         C8tGzCDaBs2UVUDp1nqlhbm36PjDCRpZaKUe+ndBTm2auGB4PXMqKmG60hZ6cOLiOizu
         G0dg==
X-Gm-Message-State: ALyK8tLJoX9qO5BqRZnv73dAXIFD3l1avd8H7jfXhHWeRufLp/Anl4XxaRg34dYiVoe9jzxPdIu1drVbgN58L/mX
X-Received: by 10.107.144.86 with SMTP id s83mr4948498iod.165.1467927697880;
 Thu, 07 Jul 2016 14:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 7 Jul 2016 14:41:37 -0700 (PDT)
In-Reply-To: <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 7 Jul 2016 14:41:37 -0700
Message-ID: <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> @@ -207,6 +214,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
>>                             "report-status delete-refs side-band-64k quiet");
>>               if (advertise_atomic_push)
>>                       strbuf_addstr(&cap, " atomic");
>> +             if (advertise_push_options)
>> +                     strbuf_addstr(&cap, " push-options");
>>               if (prefer_ofs_delta)
>>                       strbuf_addstr(&cap, " ofs-delta");
>>               if (push_cert_nonce)
>
> Hmph, was there a good reason to add it in the middle (contrast to
> the previous addition to the "only possible values are..."
> enumeration)?

No, there is no good objective reason. I added it just after the atomic
flag as that is what I implemented.

Is there a reason for a particular order of capabilities? I always considered
it a set of strings, i.e. any order is valid and there is no preference in
which way to put it.

>
>> +static struct string_list *read_push_options()
>
> static struct string_list *read_push_options(void)
>
>> +{
>> +     int i;
>> +     struct string_list *ret = xmalloc(sizeof(*ret));
>> +     string_list_init(ret, 1);
>> +
>> +     /* NEEDSWORK: expose the limitations to be configurable. */
>> +     int max_options = 32;
>> +
>> +     /*
>> +      * NEEDSWORK: expose the limitations to be configurable;
>> +      * Once the limit can be lifted, include a way for payloads
>> +      * larger than one pkt, e.g allow a payload of up to
>> +      * LARGE_PACKET_MAX - 1 only, and reserve the last byte
>> +      * to indicate whether the next pkt continues with this
>> +      * push option.
>> +      */
>> +     int max_size = 1024;
>
> Good NEEDSWORK comments; perhaps also hint that the configuration
> must not come from the repository level configuration file (i.e.
> Peff's "scoped configuration" from jk/upload-pack-hook topic)?

Ok, I reviewed that series. It is unclear to me how the attack would
actually look like in that case.

In 20b20a22f8f Jeff writes:
> Because we promise that
> upload-pack is safe to run in an untrusted repository, we
> cannot execute arbitrary code or commands found in the
> repository (neither in hooks/, nor in the config).

I agree on this for all content that can be modified by the user
(e.g. files in the work tree such as .gitmodules), but the .git/config
file cannot be changed remotely. So I wonder how an attack would
look like for a hosting provider or anyone else?
We still rely on a sane system and trust /etc/gitconfig
so we do trust the host/admin but not the user?

>
>> +     for (i = 0; i < max_options; i++) {
>> +             char *line;
>> +             int len;
>> +
>> +             line = packet_read_line(0, &len);
>> +
>> +             if (!line)
>> +                     break;
>> +
>> +             if (len > max_size)
>> +                     die("protocol error: server configuration allows push "
>> +                         "options of size up to %d bytes", max_size);
>> +
>> +             len = strcspn(line, "\n");
>> +             line[len] = '\0';
>> +
>> +             string_list_append(ret, line);
>> +     }
>> +     if (i == max_options)
>> +             die("protocol error: server configuration only allows up "
>> +                 "to %d push options", max_options);
>
> When not going over ssh://, does the user sees these messages?
>
> More importantly, if we plan to make this configurable and not make
> the limit a hardwired constant of the wire protocol, it may be
> better to advertise push-options capability with the limit, e.g.
> "push-options=32" (or even "push-options=1024/32"), so that the
> client side can count and abort early?

Yeah we may want to start out with a strict format here indicating
the parameters used for evaluating the size.
So what do these numbers mean?

I assume (and hence I should document that,) that the first (1024)
is the maximum number of bytes per push option. The second
number (32) is the number of push options (not the number of pkts,
as one push option may take more than one pkt if the first number is
larger than 65k, see the NEEDSWORK comment.)

Do we really need 2 numbers, or could we just have one number
describing the maximum total size in bytes before the remote rejects
the connection?

>
> I wondered how well the extra flush works with the extra framing
> smart-http does to wrap the wire protocol; as I do not see any
> change to the http side, I'd assume that there is no issue.

That's a dangerous assumption of yours, as I did not test the
https side, yet.

>
>> +
>> +     return ret;
>> +}
>> +
>>  static const char *parse_pack_header(struct pack_header *hdr)
>>  {
>>       switch (read_pack_header(0, hdr)) {
>> @@ -1773,6 +1829,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>>               const char *unpack_status = NULL;
>>               struct string_list *push_options = NULL;
>>
>> +             if (use_push_options)
>> +                     push_options = read_push_options();
>> +
>>               prepare_shallow_info(&si, &shallow);
>>               if (!si.nr_ours && !si.nr_theirs)
>>                       shallow_update = 0;
>
