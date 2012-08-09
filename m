From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v3 04/13] Add documentation of the index-v5 file
 format
Date: Fri, 10 Aug 2012 01:10:39 +0200
Message-ID: <20120809231039.GC5127@tommy-fedora.scientificnet.net>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-5-git-send-email-t.gummerer@gmail.com>
 <7vobmjn0wv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 01:10:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzbsU-0000uT-WA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 01:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759887Ab2HIXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 19:10:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53168 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759781Ab2HIXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 19:10:48 -0400
Received: by wgbdr13 with SMTP id dr13so900081wgb.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JxTGOiMGtkpighzYD8gXaVCgTkly3Tt1p8xtHfcuoCw=;
        b=gbdLxFxVjgBqzv1cfE67XGDAbvIm7knC9AOYTXbrPAmgjQBZbD3jQ8GiXLCCBevdvK
         KhXk9nH1Yg/nhrB6UOjkSFjqo1JV+HEHfwXqKcr4rSSG7TmDLy/LX4Mr1IoV42H6wS6W
         ZKsUEC27LeG5sHiLm5dzNfrSHC7YhKvT0GyRwVy2cVPa97UGQIBRPqWgn5EA8FZwT7g0
         YcWrmTDf79dHxLJGqv9aqmFmoLBh50Wlhdct5dDSM9MSUVd/khC8XsF/7DefgNE8VNvc
         SErEOfGAddZAA4PL1B6p0MaFZFu5T8QU3iAicim5F3KFof0aoUcNPkwpzYcpB8lG1qVQ
         HsSg==
Received: by 10.180.103.4 with SMTP id fs4mr510491wib.16.1344553846932;
        Thu, 09 Aug 2012 16:10:46 -0700 (PDT)
Received: from localhost ([95.171.54.129])
        by mx.google.com with ESMTPS id w7sm4398472wiz.0.2012.08.09.16.10.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 16:10:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobmjn0wv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203188>

On 08/09, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > +GIT index format
> > +================
> > +
> > +== The git index file format
> > +
> > +   The git index file (.git/index) documents the status of the files
> > +     in the git staging area.
> > +
> > +   The staging area is used for preparing commits, merging, etc.
> 
> The above two are not about "index file format".  It is an
> explanation of what the index is.
> 
> > +   All binary numbers are in network byte order. Version 5 is described
> > +     here.
> 
> I had to read between these two lines something like 
> 
>     ""The index file consists of various sections; the sections
>     appear in the following order in the file."""
> 
> to make sense of the document.

Thanks, I'll add that.

> > +   - A 20-byte header consisting of
> > +
> > +     sig (32-bits): Signature:
> > +       The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
> > +
> > +     vnr (32-bits): Version number:
> > +       The current supported versions are 2, 3, 4 and 5.
> > +
> > +     ndir (32-bits): number of directories in the index.
> > +
> > +     nfile (32-bits): number of file entries in the index.
> > +
> > +     fblockoffset (32-bits): offset to the file block, relative to the
> > +       beginning of the file.
> 
> Ok.
> 
> > +   - Offset to the extensions.
> >
> > +     nextensions (32-bits): number of extensions.
> > +
> > +     extoffset (32-bits): offset to the extension. (Possibly none, as
> > +       many as indicated in the 4-byte number of extensions)
> 
> OK.
> 
> > +     headercrc (32-bits): crc checksum for the header and extension
> > +       offsets
> 
> This may have to have the same "  - <section title>" at the same
> level as "A 20-byte header" and "Offset to the ext"; as it stands,
> it looks as if it is part of "Offset to the ext" which consists of
> 12 bytes.

Thanks, I'll try to write it down more clearly.

> > +   - diroffsets (ndir * directory offsets): A directory offset for each
> > +       of the ndir directories in the index, sorted by pathname (of the
> > +       directory it's pointing to) (see below). The diroffsets are relative
> > +       to the beginning of the direntries block. [1]
> 
> "ndir * diroffsets" confused me.  I think you meant to say that this
> "diroffsets" section consists of ndir entries of something and that
> each of that something is a directory offset.  It is unclear how "a
> directory offset" is represented, except that it is "relative to the
> beginning of direntry block" (and it is unclear what and where the
> direntry block is from the information given up to this point) and
> the reader can guess it is in "network byte order" (assuming it is a
> binary number).  Perhaps
> 
> 	diroffsets (ndir entries of "directory offset"): A 4-byte
> 	offset relative to the beginning of the "direntries block"
> 	(see below) for each of the ...
> 
> and drop the last sentence?
> 
> Other tables may want to be adjusted in a similar fashion.

Yes, that's what I menat to say.  Thanks.

> > +== Directory offsets (diroffsets)
> > +
> > +  diroffset (32-bits): offset to the directory relative to the beginning
> > +    of the index file. There are ndir + 1 offsets in the diroffset table,
> > +    the last is pointing to the end of the last direntry. With this last
> > +    entry, we can replace the strlen when reading each filename, by
> > +    calculating its length with the offsets.
> 
> The mention of "strlen" looks very out of place.  The reader may be
> able to guess that you want to say that the nth "string" is between
> diroffset[n] and diroffset[n+1], and these "string"s are densely
> packed so strlen(diroffset[n]) and diroffset[n+1]-diroffset[n] are
> either the same thing (or with a fixed difference, if each "string"
> is accompanied by some fixed-length data), but it is unclear what
> these "strings" represent, especially because the name of the table
> implies that you are talking about directories but strlen talks
> about filename.

Hrm maybe better like this:

+  diroffset (32-bits): offset to the directory relative to the beginning
+    of the index file. There are ndir + 1 offsets in the diroffset table,
+    the last is pointing to the end of the last direntry. With this last
+    entry, we are able to replace the strlen of when reading the directory
+    name, by calculating it from diroffset[n+1]-diroffset[n]-61.  61 is the
+    size of the directory data, which follows each each directory + the
+    crc sum + the NUL byte.

> > +== Design explanations
> > + ...
> > +[3] The data of the cache-tree extension and the resolve undo
> > +    extension is now part of the index itself, but if other extensions
> > +    come up in the future, there is no need to change the index, they
> > +    can simply be added at the end.
> 
> Interesting.  When we added extensions, we said that there is no
> need to change the index to add new features, they can simply be
> added at the end.  Perhaps the file offset table can be added as an
> extension to v2 to give us the same bisectability, allowing us a
> single entry in-place replacementability, without defining an
> entirely different format?

Only part of this is true.  v2 would allow us to add the file offset
table as extension, but the problem is the design of the sha-1 over
the whole file at the end.  That would only allow single entry 
replacements, if we then re-read the file and calculate the sha-1 at
the end.  Partial reading also could only be implemented when reading
the whole file first to check the sha-1, which defeats it's purpose.
