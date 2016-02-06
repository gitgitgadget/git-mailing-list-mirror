From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC] On the --depth argument when fetching with submodules
Date: Sat, 6 Feb 2016 08:41:38 +0100
Message-ID: <20160206074138.GA30443@paksenarrion.iveqy.com>
References: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
 <xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 08:41:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRxUj-00086Y-TV
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 08:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbcBFHlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 02:41:22 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33704 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcBFHlU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 02:41:20 -0500
Received: by mail-lf0-f50.google.com with SMTP id m1so71124296lfg.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 23:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MzVZnQuKOLPnWhBLmAtB5tQhabdlKnXPfAemmeCcFa8=;
        b=u61px7x024lYkJyhaA9oiZxbHqRKO5k2QSnff3+IKVz1+lJhibL+AD3xCMvEjQs8Ax
         72wlLXSxRk/rjogZVSZk1kRZenWm8yoyaAFFvRO82V1QmhdXT9ZhVg64eAL4kZ+0Sbaz
         in71eBfh+pal6k+LBEtzQ/AzOCWUuWckiDv/e6Y+GBCRgrlcRZN96yzAV6bRnCi1Eq+t
         OXHAL4Vbu/3XAAW/uCiFSCdOaoEpeLrrSyKwKMcJr/nplw/UMGkOTp9EnIQE18xeRlXJ
         SlRXrnboUNMS/sLXZPkmS6HzLouS1y85RQwCRSUqaJBNteDk7y9iNeZP/RaoOOgnNtqV
         EcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MzVZnQuKOLPnWhBLmAtB5tQhabdlKnXPfAemmeCcFa8=;
        b=A2MGXFVRH7AhQuhNy7m2M49PoOiHnDGXhUD3I/+q2ognHQNMk7RT9fL9ABq7k5hW4G
         QeHvVVrSR2PLjS3lTlBjUGBk8Dq4Dx9+Dc02qKZ7u7Rv1GcnUr/bXSLNi7CJdw46qpDV
         IWQ9LRTOaOJlWWQsRDVel0+mNHJBxF6yB13tVJxG0KHjbg+cClV+SEeoOxPgjsBGZBlf
         P+B9DvsBS24W9NV2zWZZI+nDc+odMRlwiDD+KZl0MhsssxLaxBYK7JaTHv+pGOeoL/An
         AES9n0tj9mRKiXMYMWHuDkl8GDLNaarY+TuqKXsq8lH0yxTTTKgCovw0lA692ov0dl+H
         CfIw==
X-Gm-Message-State: AG10YOTCkO7Suovc175TXAA0Xz8/dwXsSLgffHx73fjqQCBaT/n8fmXIuz5eGjGskLIHWw==
X-Received: by 10.25.39.134 with SMTP id n128mr8242730lfn.54.1454744479440;
        Fri, 05 Feb 2016 23:41:19 -0800 (PST)
Received: from debian (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id ax1sm2667265lbc.20.2016.02.05.23.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 23:41:18 -0800 (PST)
Received: from iveqy by debian with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1aRxUw-0001l1-Lo; Sat, 06 Feb 2016 08:41:38 +0100
Content-Disposition: inline
In-Reply-To: <xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285684>

On Fri, Feb 05, 2016 at 04:05:01PM -0800, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > Currently when cloning a project, including submodules, the --depth argument
> > is passed on recursively, i.e. when cloning with "--depth 2", both the
> > superproject as well as the submodule will have a depth of 2.  It is not
> > garantueed that the commits as specified by the superproject are included
> > in these 2 commits of the submodule.
> >
> > Illustration:
> > (superproject with depth 2, so A would have more parents, not shown)
> >
> > superproject/master: A <- B
> >                     /      \
> > submodule/master:  C <- D <- E <- F <- G
> >
> > (Current behavior is to fetch G and F)
> 

The --depth option to git submodule is something I've wondered for some
time if it was correct to implement it or not. It's clearly not a
complete feature yet and it has some weaknesses, the most obvious one
stated above.

The reason for implementing --depth in submodules was for people having
huge (or many) submodules, that they aren't interested in developing in,
but need to download to  build their project. So they want to save time
and bandwidth.

My first thought was to implement depth from the sha1 the superproject
refered sha1. However, when implementing this, git didn't support
fetching a sha1 from a remote repository for security reasons (you
should never be allowed to fetch a commit that is not reachable from a
branch or tag).

Waiting for this to be supported (an (expensive) check could be done if
the sha1 asked for exists in any branch or tag), the --depth was added
and it's a guessing game on how deep you should fetch.
-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
