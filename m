From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [jgit] index v2 pull request
Date: Tue, 11 Mar 2008 08:24:24 +0600
Message-ID: <7bfdc29a0803101924r41a6e221w3d560114fd61a90a@mail.gmail.com>
References: <20080308025027.GZ8410@spearce.org>
	 <200803100051.55367.robin.rosenberg@dewire.com>
	 <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
	 <20080311003526.GM8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>,
	git@vger.kernel.org, "Dave Watson" <dwatson@mimvista.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 03:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYuAs-0005Lx-BU
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 03:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbYCKCY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbYCKCY1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 22:24:27 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:18861 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYCKCY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 22:24:26 -0400
Received: by mu-out-0910.google.com with SMTP id i10so7499981mue.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 19:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PIoGt6agd85avXlvOyG9Vf13/nuo1Etz5SiXyV8y/Fo=;
        b=Obnc3vV0xYCrQ1gbTnDGrSejrqhFhRLzwwIUFJpqKjmPG4Xq7TPWSjjoxKihxAWxpERuk0nDwKddU9jBxQJvVRG+XEPmowru7iwIIyZWx7yWECsf4wGNCIJPz+6gQnzRbXjIEbyV6AeTVFlOe3sVhPS4gGF3PUxLf80YkQnCfxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=egrHP/FzsChijO1Gf8VENGmDVoOdVRf6RZLyVhxbxAus6fsaYRNwCp2Mat+dvvHGVqa4UKt1RvJtmvVkkzMr+5PjK8JUjuzPAXbU/k1ERbDUHfy+kp5Nj3OrKWCoWE0RGS287nFVcFws62nr5g71bCVvBlgForhFh6C2D8eWEqs=
Received: by 10.78.186.9 with SMTP id j9mr16275272huf.14.1205202264681;
        Mon, 10 Mar 2008 19:24:24 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 10 Mar 2008 19:24:24 -0700 (PDT)
In-Reply-To: <20080311003526.GM8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76785>

On Tue, Mar 11, 2008 at 6:35 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>  > I would like to volunteer to work in JGit;
>  > can someone let me know where I can pick some tasks to implement?
>
>  One of the areas that I think is really weak in JGit and that we
>  need to do a _good_ fetch/push implementation is the branch model.
>
>  For example, if you look at Repository.getBranches() it returns
>  to the caller a Collection<String>.
>
>  But in Git a branch is a heck of a lot more data, and that data is
>  relevant to the end user when we are talking about fetch and merge.
>  There are many configuration options stored in .git/config for a
>  branch, and these are (today) created by git-branch and git-checkout
>  automatically as the user creates and deletes branches.
>
>  JGit has none of this model.  It thinks all that a branch is is a
>  String.  Sad.
>
>  Another thing that bothers me is the packed refs cache.  We toss
>  away the peeled information (the "^" lines), but that data is very
>  useful when you are talking about fetch as well as a few other
>  types of operations, like plotting tag labels onto a history graph
>  (such as how gitk does it).
>
>  The Ref class was started as a means of wrapping up the various
>  important bits of data about a ref (of which branches are a subclass
>  and annotated tags with peeled data is another) but I suspect it
>  didn't quite do everything so these string APIs got created.
>
>  The above is a farily small task, one that any good OO programmer
>  should be able to tackle, but it can be challenging if you are
>  new to Git plumbing as you'll have to learn what are the important
>  parts of a branch/ref/annotated tag.
>
>  As a starting point look at the config file format in C Git and
>  see what is possible in a "branch" and "remote" section; that
>  data needs to be pretty readily available for any Ref, if such
>  data exists.  The backward mapping of Ref->Remote (which does
>  not exist yet, unless Robin created it) is quite relevant for
>  tracking branches.

I will have a look at them and will give you and update; if I have any
questions, I hope you and team wont mind :).

>
>  --
>  Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
