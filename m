From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/8] git-repack --max-pack-size: add new file statics
Date: Mon, 30 Apr 2007 21:43:53 -0700
Message-ID: <56b7f5510704302143i79aef70dg95ffa23c3138663a@mail.gmail.com>
References: <4636790C.5060908@gmail.com>
	 <7vzm4p89op.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 06:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HikDn-0004yA-Ly
	for gcvg-git@gmane.org; Tue, 01 May 2007 06:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXEAEn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 00:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXEAEn4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 00:43:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:14265 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXEAEny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 00:43:54 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1807904wra
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 21:43:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BSWda6AIbTBIm7FBWEKPvMq9fgiJBQQvjDINyWUHFeLcwYe4Vj3kSZoNqPBU8gVCsIt/OgyPSuc2vC3KEuUkH0bXDPQrbtngNe6hnR0UDGyalyLnraK3tye5w+ZsiCOf6M3WiI9X/i3Bk8W76OYccAxpAOFgYBEIrG8NWMNUx0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O1dgcRY/jueBVWlLmYYofz8pu7esXZDqyCYVCZY0c/+oe5cIYjfNCxNIPCeVymSk80x3f6XmmjFkIKq7RYJbi+whAAENOo+gf2InVTl1BgtvKvlbVURk01Yf4smZKOc8c+XE8FNyHO73LVIq5mKhN7igTFI/5p9y5iMwcu1XBVc=
Received: by 10.114.75.1 with SMTP id x1mr2272699waa.1177994633412;
        Mon, 30 Apr 2007 21:43:53 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 30 Apr 2007 21:43:53 -0700 (PDT)
In-Reply-To: <7vzm4p89op.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45911>

On 4/30/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > This adds "pack_size_limit", which will contain the limit
> > specified by --max-pack-size, "written_list", the actual
> > list of objects written to the current pack, and "nr_written",
> > the number of objects in written_list.
> > ---
> >  builtin-pack-objects.c |    4 +++-
> >
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > @@ -52,7 +52,8 @@ struct object_entry {
> > -static uint32_t nr_objects, nr_alloc, nr_result;
> > +static struct object_entry **written_list;
> > +static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
> > @@ -64,6 +65,7 @@ static char tmpname[PATH_MAX];
> > +static uint32_t pack_size_limit;
>
> This by itself does not seem to do anything (no logic, no
> command line option parsing, nothing).  Why is this a separate
> patch?

Remember this all started with me submitting
one monolithic patch which attracted some complaints.
After that,  I broke the changes into patchsets
with 3 kinds of patches:
(a) Changes (addtitions) to data structures and declarations;
(b) Code restructuring and added forward function declarations
     adding _no_ functionality;
(c) Added functionality, (almost) one function at a time.

So 1/8 is the only member of group (a).
Previously there were more changes in (a).

I'm working on another change/feature. Based on your email,
I will merge groups (a) and (b) in future patchsets.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
