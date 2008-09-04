From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [Monotone-devel] Re: [RFC] mtn to git conversion script
Date: Thu, 4 Sep 2008 12:43:09 +0300
Message-ID: <94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <20080824131405.GJ23800@genesis.frugalware.org>
	 <94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
	 <20080824224658.GA16590@spearce.org>
	 <94a0d4530808241745r3f2bdb56q9cfa8bc61f79223e@mail.gmail.com>
	 <g95eoo$5ok$8@ger.gmane.org>
	 <94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, git@vger.kernel.org
To: "Anand Kumria" <wildfire@progsoc.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 11:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbBNx-0003IY-Th
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbYIDJnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbYIDJnL
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:43:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:34124 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbYIDJnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:43:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3210845rvb.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bZXIopKGGcdi20xS9v7v2zed/HjW7WUFh7bY79zMxQs=;
        b=SuGCB+5t9mrd4eLLmIqndrwu9s8HDsHBWvA69ALbW3EXoPIEaMbx323OMZhwi80EjI
         i/0oJghxpUn9+c7gbyjdMt2TlxpbK3hPKzPn5HaD9Ivu/MDvSYy2SXXdgjqT4S8rDEyj
         JnMghpyPzG+hYz8ZvN58QxKLWKG/++DK+XEvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LL29qU58251PZiTp5FGAEoooZ71CQGsljTAmhamb4UVM6yzDAeLnkedLrWe1TvmgtU
         UaP5+4Rjm4+hKB/ldbOqulMEfpg2ebNRT1zVrgbwk/axH+00pIqKbWSusl+dEiJStWKW
         nal/MsBTjpUi8T3m27S2c/nftGAudTwhcUv7c=
Received: by 10.140.140.3 with SMTP id n3mr4397885rvd.299.1220521389059;
        Thu, 04 Sep 2008 02:43:09 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Thu, 4 Sep 2008 02:43:09 -0700 (PDT)
In-Reply-To: <94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94916>

On Thu, Aug 28, 2008 at 12:03 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Aug 28, 2008 at 8:57 AM, Anand Kumria <wildfire@progsoc.org> wrote:
>>
>> Hi Felipe,
>>
>> On Mon, 25 Aug 2008 03:45:11 +0300, Felipe Contreras wrote:
>>
>>>
>>> Anyway, very nice tool. It's going much faster (1h) compared to before
>>> (1 day).
>>
>> Will you be submitting this as something for/to contrib?
>
> Yes, that's the plan.
>
> However, I still don't have something that creates an exact clone with
> fast-import.
>
> Also, I'm trying different ways to see what would be most efficient.
> Right now it's a combination of Ruby + C, but once I get it working
> I'll post it to the OE mailing lists to see if it works fine for them
> too.
>
> Once the design is good enough I might move everything to C.
>
> Best regards.

Ok, now the basics seem to be working. So I'm uploading some code if
anyone wants to take a look.

The C code is generating a topologically sorted list of revisions, and
storing the relevant information (certs and parents) separately. This
code is very fast. It's using GLib and sqlite3, so probably the GLib
stuff should be converted to use libgit.
http://gist.github.com/8742

The Ruby code takes that input and generates an output suitable for
fast-import. It would be tedious to port the parsing stuff to C, but
straightforward.
http://gist.github.com/8740

A patch for fast-import is required, I already submitted it.

Comments?

-- 
Felipe Contreras
