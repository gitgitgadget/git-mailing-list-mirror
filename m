From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/4] ls-remote: use parse-options api
Date: Sun, 17 Jan 2016 18:27:06 +0100
Message-ID: <20160117172706.GD7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453028643-13978-4-git-send-email-t.gummerer@gmail.com>
 <20160117144409.GA15519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 18:27:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKr6l-0000Bp-K3
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 18:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbcAQR0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 12:26:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33098 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcAQR0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 12:26:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so12300268wmu.0
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 09:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xP1TyimaJLGIy2yUYTmKsAv4IHn1XM6GZkiZij2eoS4=;
        b=txbqITwsDPR24bUkVdJdNqovHMcBNsQlfDPobsu9G8C25pI2hP6Hqp1qQvH477XbPH
         LRLLW+OXJD7hjGZK+kkJq1ck+RAxjNQdhbJHr57aDZMKwaxAex8HLAw4rpR5KByNnkA9
         vvfxARWtwLKHvP3RBG4rCrOKgx8sbq0pZ0N3QfCJcecqzUiLIZbSKzL/du0jzEwTKie6
         QzFdKVuUQ35CN8hee/l1qdhQDLh2XHeoo/4XqnBrVKSRtb2VmZY8iTDzd36GdaNNN9Do
         3wxAC3KhrotRdl2N9x92YPYSK9bX7rFn+tdAVQaOjRCAwk9TYsBpMFFtPdOMw7feUv/B
         zw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xP1TyimaJLGIy2yUYTmKsAv4IHn1XM6GZkiZij2eoS4=;
        b=d3QYopWfCFs9bBsyJn+/7hNbwYKGs2WA66HpiuYxcEZv0clHdyTkU/dB+HnCCA0L5J
         HmupGA5i3M4c/Sk1fOFJTnMV7ckR6A7SQALxc7xJeNB+Ileu6poLC5AV9juGRAH9Q2nK
         0sqMKzCE2dbV6PWB5Pyj4pkc4bqdlZPfobdaBgz+NMfgWSEw7NwGjF1LxpVTRFeFdHYT
         elc39LGj5QUl5TL1i4/3kZcn7RKoDH/xj0WWWjXj2qsjYkBkjH2XiyiPku97I4BTAYxH
         xtb+VLfVee7eFfNuWiDyVdd752Xe2X4M2bDw4kbV6r3IdJNMP8iliAXK2ALbOelhmkSY
         VOYQ==
X-Gm-Message-State: ALoCoQmkLJMjjFk64b+9DRsm/RkWroS+7OZsQWNtk5wFP5f82mEVX3pafA8Ij6vjuzFGX2WPapUhdRCeiCzbwCqe8x6lQsXhnQ==
X-Received: by 10.194.7.100 with SMTP id i4mr19813698wja.76.1453051598502;
        Sun, 17 Jan 2016 09:26:38 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id i2sm19977213wjx.42.2016.01.17.09.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 09:26:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160117144409.GA15519@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284262>

On 01/17, Jeff King wrote:
> On Sun, Jan 17, 2016 at 12:04:01PM +0100, Thomas Gummerer wrote:
>
> > Currently ls-remote uses a hand rolled parser for the its command line
> > arguments.  Use the parse-options api instead of the hand rolled parser
> > to simplify the code and make it easier to add new arguments.  In
> > addition this improves the help message.
>
> Sounds like a good idea.
>
> > +	int tags = 0, heads = 0, refs = 0;
> > [...]
> > +		OPT_SET_INT('t', "tags", &tags, N_("limit to tags"), REF_TAGS),
> > +		OPT_SET_INT('h', "heads", &heads, N_("limit to heads"), REF_HEADS),
> > +		OPT_SET_INT(0, "refs", &refs, N_("no magic fake tag refs"), REF_NORMAL),
> > [...]
> > +	flags = tags | heads | refs;
>
> Is there any reason these can't be:
>
>   OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
>   OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
>   OPT_BIT(0, "refs", &flags, N_("no magic fake tag refs"), REF_NORMAL),
>
> to make their interaction more obvious? I wondered if there was
> anything tricky going on (like some of the bits for each option
> overlapping), but I didn't see anything.

I was looking for something like this, but totally overlooked it when
going through the docs.  Thanks, will change.

> > +		OPT_SET_INT(0, "refs", &refs, N_("no magic fake tag refs"), REF_NORMAL),
>
> I imagine you took the help string from the comment in check_ref. We can
> probably come up with something more descriptive for the user-facing
> string. :) How about "do not show peeled tags"?

Indeed, I wasn't really happy about it, but couldn't come up with
anything better.  Your version sounds much better, will fix.

> > +		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
> > +			   N_("path of git-upload-pack on the remote host")),
> > +		OPT_STRING(0, "exec", &uploadpack, N_("exec"),
> > +			   N_("path of git-upload-pack on the remote host")),
>
> Since these are redundant with each other, should we declare one
> "hidden" to not appear in "-h" output?

Makes sense, I'll declare the exec option as hidden, as that's the one
that's not documented anywhere else either.

> > +		OPT_SET_INT(0, "get-url", &get_url,
> > +			    N_("take url.<base>.insteadOf into account"), 1),
>
> Should this one be OPT_BOOL? I think "--no-get-url" works either way (it
> resets the variable to 0), but OPT_BOOL communicates the intent more
> clearly, I think.

Makes sense, will change in the re-roll.

>
> > +		OPT_SET_INT(0, "exit-code", &status,
> > +			    N_("exit with exit code 2 if no matching refs are found"), 2),
>
> This one can't be OPT_BOOL, obviously. What happens with
> "--no-exit-code"? We'll set it back to "0", which I think is the right
> thing to do. Good.
>
> The rest of the patch looked good to me.

Thanks for the review!

>
> -Peff

--
Thomas
