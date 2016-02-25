From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is
 sloppy
Date: Wed, 24 Feb 2016 16:55:13 -0800
Message-ID: <20160225005513.GP28749@google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
 <1456284017-26141-3-git-send-email-sbeller@google.com>
 <20160224211947.GO28749@google.com>
 <CAGZ79kZvD4zFA61XvSLa8fe1PzH91+4ii5vSeH-P+ER2wbQy2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:55:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkDE-0001Yk-2K
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbcBYAzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:55:19 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36183 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbcBYAzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:55:17 -0500
Received: by mail-pf0-f175.google.com with SMTP id e127so22466535pfe.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fvLCcxww1ZJAyE7nDIjwYcYvEAFxPVtZluinZ7nfmno=;
        b=GzzjUiSy1pJXu7OcLaKG6pfJrWNK9ZKU+pKoJ0rVgx+wavVTAMB9CRRUIJVvZtJlUq
         XhUOcU1r8oYE4fl+Ow1QbB6IYZ+Zo5ColYrQk5MlEs6ORX4zb7IWvZlRpVYHvgqYjAev
         DGzjDf8suLEmABT7noeHTCgLaYWdFpxWPufr5WumP4bVFPQbT5cXHYSxiHIbzdzyDYXp
         xAYkvNyYvXHUtjBEcKGTtOywyzOP7mdPmGOvQebUxC896cvNfYy9kt0X6pGEBusMfUto
         Ywha6nvCl4IeG0V0mJW4nWnSWsJjAm94RDRhw3dQq6bjRlg2NrVhwMUDSHc8kltHVfkq
         hfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fvLCcxww1ZJAyE7nDIjwYcYvEAFxPVtZluinZ7nfmno=;
        b=eTZeBJT5yi9Gl1aYAImRYlPiircj7L+Uye07hLVXGTAvE5V2/zbhNDYy9MqKYGBoTn
         2Ct/mj7RKKS5d1ciBhUVtUuN+0fbNdM2s3/jGxFK9i/zytZKqCweUJ7x81wlmiOpli++
         967kGLslcve8TxsMyf8U4Kn7Fq/zy6dAQG4BYB+/vJXtmejNelc7Udzjr/AQS423SAZU
         Af3U+2L5VbdSqfFKudm1LS0ys8AMCckE7bucRUOgOb2R7F3M3QM0MfHo1GzeWcNXOZhH
         pn31d6M5iqFNE85SMopoet99BJ1WE3f0iKcjqqq3M0pydHxlBvGju0THLrXilx0dJKGz
         7mGg==
X-Gm-Message-State: AG10YOSiqNa9akQyt9cctakX0qFNI/SeuXHSZ9zy23CjjUmbbbI2gtLDfyMLveS51vOfSA==
X-Received: by 10.98.10.139 with SMTP id 11mr59173448pfk.87.1456361716568;
        Wed, 24 Feb 2016 16:55:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41cf:620e:463d:86cf])
        by smtp.gmail.com with ESMTPSA id i13sm7573472pfi.95.2016.02.24.16.55.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 16:55:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZvD4zFA61XvSLa8fe1PzH91+4ii5vSeH-P+ER2wbQy2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287299>

Stefan Beller wrote:
> On Wed, Feb 24, 2016 at 1:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Stefan Beller wrote:

>>> When the callers of parallel processing machine are sloppy with their
>>> messages, make sure the output is terminated with LF after one child
>>> process is handled.
>>
>> Why not always add \n here?
>
> So you propose to always add a \n if the output length was > 0 ?

Ah, now I see where I was confused.

I was seeing an analogy to functions like ref_transaction_begin(),
which use a 'struct strbuf *err' argument to store the argument to
die() that describes why they failed.  They get used like this:

	struct strbuf err = STRBUF_INIT;
	if (ref_transaction_begin(..., &err))
		die(err.buf);

and die() appends a \n at the end.  They typically are implemented
like this:

	if (open(...)) {
		strbuf_addf(&err,
			    "cannot open '%s': %s", ..., strerror(errno));
		return -1;
	}

When the function doesn't fail, err doesn't need to be inspected at all.

get_next_task_fn et al looked similar to that pattern, but they are
doing something different.  The strbuf passed in is the same buffer
that is used to collect the child process's output.  Writing to that
strbuf is not a way to provide an error message for die() --- instead,
it is a way to provide additional output that should be combined with
the child process's output.

Renaming the parameter to something like 'struct strbuf *out' would
have avoided this clash of conventions and got me un-confused.  That
would make it clearer that the callback function should do

	strbuf_addf(out, "warning: foo\n");

including both its own 'warning: ' prefix and its own newline.  It is
providing output meant to be passed as-is to the terminal.

That is a convenient API since if you want to write multiple messages,
you can do

	if (foo)
		strbuf_addf(out, "warning: foo\n");

	... do some other things ...

	if (bar)
		strbuf_addf(out, "warning: bar\n");

The newlines avoid the messages running together.

The functions default_start_failure and default_task_finished are
buggy under that API, since they do not include newlines in their
output.

Once they're fixed, there wouldn't be any need to add \n, unless we
are worried about a child process that writes output that doesn't end
with a newline.  It can be convenient for child processes to do things
like

	printf '%s\t' "some information"

so I am not convinced this patch is helping.

Does that make sense?

Sorry for the confusion,
Jonathan
