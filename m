Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB40203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbcLLWuK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:50:10 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35790 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcLLWuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:50:09 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so14642120pfk.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bckQSCUFqxwtyNfv0KoQVehzMmzmOWeTUffQEAwu4Ko=;
        b=Kqy4zi6676gcCMFtnc3X6b5uLW7fbos04Oj5RWQrpWYRBXwK9AnXCQ7NvsXh15UxzU
         f34HRumb6j9EcN2PqLM0D3xPer37eZlBiKdqnAf/8FRN3dcqOk2/S4TseWe4PtINGDW8
         3eEGctXAXajLfvOa9i638RTEu5YvyRf7k/d4XoKLVX5Z8Fzsk0Ogn8pw2Fj5DymEU77E
         sHDJ5M2lyzNRo2OkbmhRyJRqCclKR+qQxtnse9B4097j5OnWub0xCPtWnU0eZklPfrnm
         QWvB2Befbj16Y1GnFz6E+tw1cCdyhwWvGvtjiQ+8iib6X58JVpY0ZvPxIlEmJOaFT+qD
         uWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bckQSCUFqxwtyNfv0KoQVehzMmzmOWeTUffQEAwu4Ko=;
        b=BzV1zlT2NFQabSbxAogqluuzrUqPzC6kexCzZjI8d4LT2u3jFJ9wPWDaGOXUYgvS8v
         Se1eGOGlVXaFB5TSZFCX4Ox9KMev9Ynmi2lzynsNwkNT4lmn2I98TaaGJTQ/Pfl5psWG
         oSoft0QeA/q8KF4N7Hqhr+hQLoPtKu009e5R61Hb8tXcb7UDyYw52ii0fh1uOcVfxmne
         6yw9+BJQiBUnA4vJQzmXs8p7eKbfgE685HgMBSuhTKZkiGJrzaGGRdO5FqQV9m2paPfG
         uWrf8Ljx/sdpp9QQm8SpzGYDh9F+2BQuZud9/nsdlire74YamH6/INqTdHEdcmvXvBRH
         y5hg==
X-Gm-Message-State: AKaTC01frojNTTX4/4aRoz84wEnsKFj1NhlQPGwTZAcENhFwk5O1A5I++gVQyZI7obV6AfSo
X-Received: by 10.98.16.132 with SMTP id 4mr100113141pfq.163.1481583008746;
        Mon, 12 Dec 2016 14:50:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b51d:6a5e:36ae:c0a])
        by smtp.gmail.com with ESMTPSA id 2sm78232998pgy.27.2016.12.12.14.50.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 14:50:07 -0800 (PST)
Date:   Mon, 12 Dec 2016 14:50:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 1/4] real_path: resolve symlinks by hand
Message-ID: <20161212225006.GB193413@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
 <1481566615-75299-2-git-send-email-bmwill@google.com>
 <xmqqd1gw94f1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1gw94f1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +/* removes the last path component from 'path' except if 'path' is root */
> > +static void strip_last_component(struct strbuf *path)
> > +{
> > +	size_t offset = offset_1st_component(path->buf);
> > +	size_t len = path->len;
> > +
> > +	/* Find start of the last component */
> > +	while (offset < len && !is_dir_sep(path->buf[len - 1]))
> > +		len--;
> 
> If somebody at a higher level in the callchain has already
> normalized path, this is not a problem, but this will behave
> "unexpectedly" when path ends with a dir_sep byte (or more).
> 
> E.g. for input path "foo/bar/", the above loop runs zero times and
> then ...
> 
> > +	/* Skip sequences of multiple path-separators */
> > +	while (offset < len && is_dir_sep(path->buf[len - 1]))
> > +		len--;
> 
> ... the slash at the end is removed, leaving "foo/bar" in path.
> 

The way this is currently used I don't believe this scenario can happen
(since input to this shouldn't have trailing slashes), but if others
begin to use this function then yes, that is an implicit assumption.  I
think it may be an ok assumption though since this is only called on
"resolved" which is the ouput and needs to be normalized to begin with. To
fix this we could simply add the while loop that strips dir_sep at the
beginning as well as at the end, like so:

  /* Skip sequences of multiple path-separators */
  while (offset < len && is_dir_sep(path->buf[len - 1]))
  	len--;
  /* Skip sequences of multiple path-separators */
  while (offset < len && !is_dir_sep(path->buf[len - 1]))
  	len--;
  /* Skip sequences of multiple path-separators */
  while (offset < len && is_dir_sep(path->buf[len - 1]))
  	len--;

> > +	strbuf_setlen(path, len);
> > +}
> > ...
> > +/* get (and remove) the next component in 'remaining' and place it in 'next' */
> > +static void get_next_component(struct strbuf *next, struct strbuf *remaining)
> > +{
> > +	char *start = NULL;
> > +	char *end = NULL;
> > +
> > +	strbuf_reset(next);
> > +
> > +	/* look for the next component */
> > +	/* Skip sequences of multiple path-separators */
> > +	for (start = remaining->buf; is_dir_sep(*start); start++)
> > +		; /* nothing */
> > +	/* Find end of the path component */
> > +	for (end = start; *end && !is_dir_sep(*end); end++)
> > +		; /* nothing */
> > +
> > +	strbuf_add(next, start, end - start);
> > +	/* remove the component from 'remaining' */
> > +	strbuf_remove(remaining, 0, end - remaining->buf);
> > +}
> 
> Unlike the strip_last_component(), I think this one is more
> carefully done and avoids getting fooled by //extra//slashes// at
> the beginning or at the end, which does help in the correctness of
> the loop we see below.
> 
> > @@ -58,74 +88,112 @@ static const char *real_path_internal(const char *path, int die_on_error)
> >  			goto error_out;
> >  	}
> >  
> > +	strbuf_reset(&resolved);
> > +
> > +	if (is_absolute_path(path)) {
> > +		/* absolute path; start with only root as being resolved */
> > +		int offset = offset_1st_component(path);
> > +		strbuf_add(&resolved, path, offset);
> > +		strbuf_addstr(&remaining, path + offset);
> > +	} else {
> > +		/* relative path; can use CWD as the initial resolved path */
> > +		if (strbuf_getcwd(&resolved)) {
> > +			if (die_on_error)
> > +				die_errno("unable to get current working directory");
> > +			else
> > +				goto error_out;
> >  		}
> > +		strbuf_addstr(&remaining, path);
> > +	}
> >  
> > +	/* Iterate over the remaining path components */
> > +	while (remaining.len > 0) {
> > +		get_next_component(&next, &remaining);
> > +
> > +		if (next.len == 0) {
> > +			continue; /* empty component */
> > +		} else if (next.len == 1 && !strcmp(next.buf, ".")) {
> > +			continue; /* '.' component */
> > +		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
> > +			/* '..' component; strip the last path component */
> > +			strip_last_component(&resolved);
> 
> Wouldn't this let "resolved" eventually run out of the path
> components to strip for a malformed input e.g. "/a/../../b"?
> 

As I understand it, that path is correct and would resolve to "/b".  The
strip_last_component function doesn't allow striping the "1st" component
or the "root" component.  So if resolved is "/" and we encounter a ".."
which requires striping of the last component, the result would be "/".

> > + ...
> > +			/*
> > +			 * if there are still remaining components to resolve
> > +			 * then append them to symlink
> > +			 */
> > +			if (remaining.len) {
> > +				strbuf_addch(&symlink, '/');
> 
> This can add duplicate dir_sep if readlink(2)'ed contents of the
> symbolic link already ends with a slash, but I think it (together
> with the fact that the code does nothing to normalize what is read
> from the symbolic link) probably does not matter, given the way how
> get_next_component() is implemented.
> 

Yes, I think the way get_next_component() is written will account for
non-normalized symlink contents.  This way we only have to worry about
normalizing input in one location (maybe two with
strip_last_component()).

> > +				strbuf_addbuf(&symlink, &remaining);
> > +			}
> > +
> > +			/*
> > +			 * use the symlink as the remaining components that
> > +			 * need to be resloved
> > +			 */
> > +			strbuf_swap(&symlink, &remaining);
> > +		}
> >  	}
> >  
> > +	retval = resolved.buf;
> > +
> >  error_out:
> > +	strbuf_release(&remaining);
> > +	strbuf_release(&next);
> > +	strbuf_release(&symlink);
> >  
> >  	return retval;
> >  }
> 

-- 
Brandon Williams
