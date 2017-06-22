Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1361F2082E
	for <e@80x24.org>; Thu, 22 Jun 2017 23:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbdFVX7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:59:35 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35344 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbdFVX7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:59:34 -0400
Received: by mail-pg0-f47.google.com with SMTP id 132so14238059pgb.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ER7WR/I3JDOcdB5G3Ss2fo2vKDHsfWzLQk8xmsuLiE=;
        b=DfdJUW/aCVD9MfDMhErSxIacUMyo0K4AoCYMFi5UiJDg08D+oJdvkZRW2D2ZFmfhZS
         DWAIHZASyLpfRZ8di1YE9ahipbHmQRNA/2wFmdQpD0odYJcZJmdN1wbqtngh3vdp7z6J
         ifUMXMgHTnJFrNozds2ZDAqyhtwLV8mvOChshc2n9r+cm9r8dVjqcR+XW2duG79ikpiq
         lD0bidGzWC/ltnzCRTCI8trQTc1n4OrKKSm4jJCy3JHBmeuJ8p//JWQmanJZnXfnnw69
         xebtw5dYvmxG6MbWoUGvy0jZn+Mkr4lkpWzzpe47HIXCMOeJicXPaQdcruxK+8FHcPte
         xjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ER7WR/I3JDOcdB5G3Ss2fo2vKDHsfWzLQk8xmsuLiE=;
        b=Pwc+q6DKooprYprTp+BRYrl3/4f+0OssTZLgFOPlJehDDt5lME8Tc3ZB6avvhndPjJ
         C/9MG6zXVqHc1gsu3VRRmXcE5SMRS0Fh4ql2WAGhjmoLJ9GdniRJD4MGcUZOKcC3aGp/
         RpZt0V199jXSHlNlxZBYcYaDV8YXQ/7c1xG1LYQtg/42+gal6+Jw08eBWixuP+6F6SAz
         fkihuR7MJHsvzZyI/gGYi9NwUUj5GMzXiXbtSoeqDDaSIpmFnO3ABI+9rIkbVHKF+HYU
         2uoxPk9HVwIssyEthrji1b10zibxUUvBLt8BpnvTFVIxnWwEUbVkTi+bH8FsvX0+6MZZ
         I5pA==
X-Gm-Message-State: AKS2vOxnNPcH0/OR0wz4BR5Qev9eHEEIjHH2/10fTF72aY+TlP7KqIFw
        VR+xAK0EJnbNfl8Pi0sOCX7GtARla/7F
X-Received: by 10.84.232.205 with SMTP id x13mr5817472plm.245.1498175974063;
 Thu, 22 Jun 2017 16:59:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 16:59:33 -0700 (PDT)
In-Reply-To: <xmqqvanpnlva.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-12-sbeller@google.com>
 <20170620130147.75e1fb78@twelve2.svl.corp.google.com> <xmqqvanpnlva.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 16:59:33 -0700
Message-ID: <CAGZ79kZPcQd8oy2Q23v3vN9h667fu+SYjQ8ttDxgoRmH80QQzg@mail.gmail.com>
Subject: Re: [PATCH 11/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> On Mon, 19 Jun 2017 19:48:01 -0700
>> Stefan Beller <sbeller@google.com> wrote:
>>
>>> @@ -676,6 +677,14 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>>>              }
>>>              emit_line(o, context, reset, line, len);
>>>              break;
>>> +    case DIFF_SYMBOL_FILEPAIR:
>>> +            meta = diff_get_color_opt(o, DIFF_METAINFO);
>>> +            reset = diff_get_color_opt(o, DIFF_RESET);
>>> +            fprintf(o->file, "%s%s%s%s%s%s\n", diff_line_prefix(o), meta,
>>> +                    flags ? "+++ " : "--- ",
>>
>> I think that a constant should be defined for this flag, just like for
>> content lines. If not it is not immediately obvious that a flag should
>> be set for the +++ lines.
>
> True.
>
>>> +                    line, reset,
>>> +                    strchr(line, ' ') ? "\t" : "");
>>> +            break;
>
> Also this is somewhat misnamed in that a call to it only deals with
> one half of a filepair, iow, the caller must call it twice to show a
> single filepair.

Split into two and renamed to DIFF_SYMBOL_FILEPAIR_PLUS
and DIFF_SYMBOL_FILEPAIR_MINUS.

Thanks,
Stefan
