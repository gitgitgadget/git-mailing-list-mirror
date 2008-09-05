From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Git Community Book
Date: Sat, 6 Sep 2008 01:09:41 +0300
Message-ID: <94a0d4530809051509y5f3cf2f6g209047debc584ed9@mail.gmail.com>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
	 <7vmyimv0qr.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0809051434g4e92790fsa38d12487630aa9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbjXv-0005sd-C3
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 00:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYIEWJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 18:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbYIEWJn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 18:09:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:24792 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYIEWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 18:09:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so623112rvb.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 15:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=r4bCgofMIGDAEZaRYWLBl6um6NTeH99qsiOAFqy5xmI=;
        b=SpNVmg4Jnd7viImYrTV/3tSWn+25a0OciBCLipAN2hwyESaLngTRSIQx3a8attszgu
         Cz991tW1JYwTt18OCKR6FiqRUSivO3/OQ75LgPWjVgM36XpiUEdGKjdCIo9ZFnmSWKbp
         P3UMiN7edFOz9pdGLGBTNUGvcdJIQa/RaT/hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fxJXHk5IGPy/wI53JD3AKgSNiRVYtPIN12ukfrKIVIMEpHnXKZBnfyT9om4gOZ+NtB
         /vTuxhAqD9kUuc3ZGKNgTgoImUgeWLX1cWZga+mVwt/3ZeeB2+ccU/mhb437aH/oxXbG
         NPQEH4utOZJXfcxMgwXFS9emxabd2RclGwhDY=
Received: by 10.140.178.17 with SMTP id a17mr6957349rvf.156.1220652581334;
        Fri, 05 Sep 2008 15:09:41 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Fri, 5 Sep 2008 15:09:41 -0700 (PDT)
In-Reply-To: <d411cc4a0809051434g4e92790fsa38d12487630aa9f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95044>

On Sat, Sep 6, 2008 at 12:34 AM, Scott Chacon <schacon@gmail.com> wrote:
> On Fri, Sep 5, 2008 at 12:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Scott Chacon" <schacon@gmail.com> writes:
>>
>>> Also, the last section of the book is on some of the plumbing - mostly
>>> stuff I've found difficult to pick up with the existing documentation
>>> while re-implementing stuff in Ruby.  I would really appreciate it if
>>> someone could proofread some of these chapters for errors:
>>>
>>> http://book.git-scm.com/7_the_packfile.html
>>
>> Nice pictures.  You might also want to know that code for reading pack idx
>> version 2 was backported to 1.4.4.5 for people who are stuck on 1.4.4
>> series for whatever reason.
>>
>> What is the target audience of this section?  If it is written for a mere
>> curious type, or if it is written to give "here is the general idea, for
>> more details read the source", the level of detail here would be Ok.
>>
>> If you are writing for people who want to (re)implement something that
>> produces these files, you might want to at least say that offset/sha1[]
>> table is sorted by sha1[] values (this is to allow binary search of this
>> table), and fanout[] table points at the offset/sha1[] table in a specific
>> way (so that part of the latter table that covers all hashes that start
>> with a given byte can be found to avoid 8 iterations of the binary
>> search).
>>
>> <data> part is just zlib stream for non-delta object types; for the two
>> delta object representations, the <data> portion contains something that
>> identifies which base object this delta representation depends on, and the
>> delta to apply on the base object to resurrect this object.  ref-delta
>> uses 20-byte hash of the base object at the beginning of <data>, while
>> ofs-delta stores an offset within the same packfile to identify the base
>> object.  In either case, two important constraints a reimplementor must
>> adhere to are:
>>
>>  * delta representation must be based on some other object within the same
>>   packfile;
>>
>>  * the base object must be of the same underlying type (blob, tree, commit
>>   or tag);
>>
>>> http://book.git-scm.com/7_raw_git.html
>>
>> I am guessing this is for Porcelain writers who use plumbing.  Please
>> don't teach echoing into .git/refs/...  but DO teach using update-ref with
>> the -m option.  We do not want people's random Porcelains flipping the tip
>> of branches without leaving trail in reflog for users to use to recover
>> from mistakes.
>>
>
> I've implemented all of these and Linus's fixes and suggestions.
> Thanks for the feedback.
>
> To answer your earlier question, these docs are basically for people
> working on bindings/re-implementations in other languages, since there
> is no real linked library available yet, as a primer before they dig
> into the source, or possibly so they don't have to.
>
> I'm not fantastic at C, so it took me a while in some cases - figuring
> out that the size listed in the object header was not the actual size
> of the data, but the size of it when expanded, for example, was not
> very easy to do.  I've been doing a lot of work on re-implementations
> in Ruby and ObjC because I can't easily make real bindings, so I
> thought I would add things that I could not easily find in the docs
> for others that are trying in other languages.

I have experience mixing C and Ruby code if you are interested, it's
actually quite easy.

I also think a shared library would make sense.

Keep up the good work ;)

-- 
Felipe Contreras
