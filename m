Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F2F201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbdEODc1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:32:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35922 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbdEODc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:32:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so13014695pfb.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+/4N0/HHmnd30bE1yKh/v2yMHsfwsMWIDGjOz0PJQuw=;
        b=aRp6jUPvw/mFNghActSNnyEzfNPt3Infy3mvQoBOwHJlB8R7+TP5icPmBRDmijAOdV
         /CtFZBSzI9DZSwTC7FTp2MnrpCvAcqt9E9ljzlLfR53bztUtdDMIjNZ59bI31hVhBfje
         Iz1c8+VCuoj4NpR5FbieJzxLckIC8OhifMfOHlhHFhmNlOC1Je3Y5m/Qoiu3rQtT2XDa
         lcE4cEHM8sUjpbOdT0sDjKXLPwkaHfM7xCZcMdvp2N6NckBTswFihlyBqLkDyootO/4j
         wHTbTcCV8hjPLKwnwVFTCxWEHsj2PKssXyjhqE6O+KM1ni0snmY2hvgZHeb2v2XePDfR
         dJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+/4N0/HHmnd30bE1yKh/v2yMHsfwsMWIDGjOz0PJQuw=;
        b=gVvGzL4Ysmj4MzZjszezv1hdyHYOncR2Nv/PD/Ou5T1uLBfetN4cM3Sh2Bqu25om2M
         iEsLrIA+Ozh0MMtJWnM7IPObMkXVTdHlcDaZq4Bj5GJEsUg0jw8O9z3iTTSje86Fjo6Z
         roH4FWr5kk4qeRzb9nzkxfk6Ji/my+/DH3EU7jdfSUef3/0XlVqbIGCaFnNH9TPfK20r
         N7mj5NNqMI3dpx+T2LKHlhKhEfb9uAoFdTZKvTamyd9OYq9ebf/rfhiKbRRVuvJdw31k
         yt9WGOyABH3agV+Xfu6X4W4xdAZoQVPGCuuzoR/fgBCbP3//Qoqbo/DrVNgDphGgeDGg
         eoqQ==
X-Gm-Message-State: AODbwcDslF/XFzFtRHguXfAyvo9lxB+NqejWZEwPc8a8GXvTx/4AbykG
        UKPqnKOMXADOSQ==
X-Received: by 10.98.99.135 with SMTP id x129mr4075262pfb.4.1494819145780;
        Sun, 14 May 2017 20:32:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id y20sm9683649pfb.93.2017.05.14.20.32.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 20:32:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brian Malehorn <bmalehorn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
        <20170514033923.12870-1-bmalehorn@gmail.com>
        <20170514033923.12870-2-bmalehorn@gmail.com>
        <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
        <xmqqfug6yiks.fsf@gitster.mtv.corp.google.com>
        <20170515030726.mmbb43zxqgtbrbuy@sigill.intra.peff.net>
Date:   Mon, 15 May 2017 12:32:24 +0900
In-Reply-To: <20170515030726.mmbb43zxqgtbrbuy@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 14 May 2017 23:07:26 -0400")
Message-ID: <xmqqpofax0af.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 15, 2017 at 11:12:03AM +0900, Junio C Hamano wrote:
>
>> >> diff --git a/builtin/commit.c b/builtin/commit.c
>> >> index 2de5f6cc6..2ce9c339d 100644
>> >> --- a/builtin/commit.c
>> >> +++ b/builtin/commit.c
>> >> @@ -1735,7 +1735,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>> >>  
>> >>  	if (verbose || /* Truncate the message just before the diff, if any. */
>> >>  	    cleanup_mode == CLEANUP_SCISSORS)
>> >> -		wt_status_truncate_message_at_cut_line(&sb);
>> >> +		strbuf_setlen(&sb,
>> >> +			      wt_status_last_nonscissors_index(sb.buf, sb.len));
>> >
>> > This hunk surprised me at first (that we would need to touch commit.c at
>> > all), but the refactoring makes sense.
>> 
>> This still surprises me.  If the problem is in interpret-trailers,
>> why do we even need to touch cmd_commit()?  If GIT_EDITOR returns us
>
> The behavior of cmd_commit() shouldn't be changed by the patch. But to
> make the interface suitable for the new callsite (which doesn't have a
> strbuf, but a ptr/len buffer), it needs to return the length rather than
> shortening the strbuf. We could leave in place:
>
>   void wt_status_truncate_message_at_cut_line(struct strbuf *sb)
>   {
> 	strbuf_setlen(sb, wt_status_last_nonscissors_index(sb->buf, sb->len));
>   }
>
> but it would only have this one caller.
>
> If I were doing the patch series, I'd probably have split that
> refactoring into its own patch and discussed the reason separately. I
> waffled on whether or not to ask Brian to do so (and obviously didn't in
> the end).

I suspect that you would have just explained "since there is only
one caller, let's open-code it" in the log message, without making
this a two-patch series, and that would also have been perfectly
understandable (and in this case probably preferrable).

So the patch text would be OK; it was surprising to have the change
without being explained, that's all.

Thanks.

