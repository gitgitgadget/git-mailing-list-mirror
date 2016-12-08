Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3241B1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbcLHSUC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:20:02 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34365 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLHSUB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:20:01 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so176456976pgx.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=68sfXIUd7RcyfuOuqPEFYqU5JgWZizKW9D+coF9E57w=;
        b=ULtIH2uOQMz0Dee3OALCsLTzte7zyEBIZBT7CKCnW+hhvY+UI6TTJbWcdR6VfhDof8
         cXVfdZXnV8O/MeuU/xrFT6qXE6ztopCQePkV4lir+QtTL7H1Wb4P/F39l4IsU51xsZaT
         C92xCRqprucGu4twyw6b7BPZJqfOGOQhG7wm3w40Cbig6AFp+mdjkFVMCsXm60K9DY+6
         X+zIRjxqiOEnal6x7la/2hPkewuWLs4OvvT71ssmd+2BIj+fSmQdfVOduHn4dfyhlt4r
         ncKW48k85BZCo88/neBRcoHRbigV584CY4lcLuopbKRyzXj3bv9RZhsX91szHhKNF0Q7
         j90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=68sfXIUd7RcyfuOuqPEFYqU5JgWZizKW9D+coF9E57w=;
        b=HJh9yMt77DynJX0pXC+4zCtF+rMC06cyaOiuT+cfWTtyT7UCwtUIA5wMfHjnauNqcO
         L9FHGpweiFYcI5dJqhMqygyK8dAp1sPYF5cxJCB0s1QwAwoe9vcfHlK8lt+xv13A75Hv
         lc1gHasFezeahiAr9hG9m/WT0pyiWPzpgVnuhegwQTDLIUOjD5POpZdDXnMFv7W3t2aO
         qY1aZ3Xkm9WNYdfV+kq34o0FBADagfrLt7Wj2hsebsje7XcqozAfGc4qSbAo4ssT2bCh
         zIJ4TbgrYEJvxN/odNNMfGZBwXWBhRArPOYyjZvC+E3A6sxWaboRWz9CryCHnlMjkoST
         UaXQ==
X-Gm-Message-State: AKaTC00+k0F22BBkvI5hagroP+uqmKjFk40vN1UVeHkuU+uHcl9bA1B09T0lI0nAIb+xdLbV
X-Received: by 10.99.173.68 with SMTP id y4mr132565174pgo.54.1481221200477;
        Thu, 08 Dec 2016 10:20:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5c3f:7794:7672:2048])
        by smtp.gmail.com with ESMTPSA id u23sm51708781pfg.86.2016.12.08.10.19.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:19:59 -0800 (PST)
Date:   Thu, 8 Dec 2016 10:19:57 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
Message-ID: <20161208181957.GP116201@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-3-git-send-email-bmwill@google.com>
 <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
 <20161208000357.GJ116201@google.com>
 <CACsJy8DtUwnOjBV49navkfgqPzEsNuX2LVaeVU=Ap2PWLpGFdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DtUwnOjBV49navkfgqPzEsNuX2LVaeVU=Ap2PWLpGFdA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Duy Nguyen wrote:
> On Thu, Dec 8, 2016 at 7:03 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/07, Duy Nguyen wrote:
> >> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> >> > Convert 'create_simplify()' to use the pathspec struct interface from
> >> > using the '_raw' entry in the pathspec.
> >>
> >> It would be even better to kill this create_simplify() and let
> >> simplify_away() handle struct pathspec directly.
> >>
> >> There is a bug in this code, that might have been found if we
> >> simpify_away() handled pathspec directly: the memcmp() in
> >> simplify_away() will not play well with :(icase) magic. My bad. If
> >> :(icase) is used, the easiest/safe way is simplify nothing. Later on
> >> maybe we can teach simplify_away() to do strncasecmp instead. We could
> >> ignore exclude patterns there too (although not excluding is not a
> >> bug).
> >
> > So are you implying that the simplify struct needs to be killed?  That
> > way the pathspec struct itself is being passed around instead?
> 
> Yes. simplify struct was a thing when pathspec was an array of char *.
> At this point I think it can retire (when we have time to retire it)

Alright, then for now I can leave this change as is and have a follow up
series that kills the simplify struct.

-- 
Brandon Williams
