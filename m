From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Mon, 14 May 2012 17:01:13 +0200
Message-ID: <20120514150113.GD2107@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu>
 <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <4FAA2CAF.3040408@alum.mit.edu>
 <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
 <20120511171230.GA2107@tgummerer>
 <4FB01080.6010605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 14 17:01:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STwmB-0000jN-51
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 17:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab2ENPBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 11:01:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54142 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab2ENPBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 11:01:22 -0400
Received: by obbtb18 with SMTP id tb18so7527612obb.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2LVjYJjKs4QcuZYUQXdL4XyfbCo/8QNZaSNWLRGo6Zc=;
        b=Gn/kMIrI5UdHK5UdHquGFNVQUR6DnfvQQthdQW3ZQt0yyTnRGBbBrBMuY56Rp+qZIx
         oBIlGZLfLcZavDJQm9D5PnODMx9ww94WJQ+uY+HOi0rv6YQuhdTJbyWk5Aej5NQis0bb
         svkQQivSY7xUCGl5PVkEOOdiG2HkCXK2pisZqQ6oqsZKWvNdwffripYX03nIUE74PYxE
         78pKATQWmBXe7NBExST6mt9BhHLT8tXAaFYjlhwDkIWKSH232aOjCS5E74JNXJsCc/dV
         ZQHaUzNRlD59ln54pF7XaJ4XcBnBshhSpM1dRKs+lyJF/0+4jrIerFHqg3sMxBTwmJiR
         0PJw==
Received: by 10.182.149.9 with SMTP id tw9mr12552356obb.45.1337007681191;
        Mon, 14 May 2012 08:01:21 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id s8sm15407438oec.1.2012.05.14.08.01.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 08:01:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB01080.6010605@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197775>



On 05/13, Michael Haggerty wrote:
> On 05/11/2012 07:12 PM, Thomas Gummerer wrote:
> >Thanks for your feedback! To get clearer code I've now written a
> >working reader for the v5 index format in Python. The full reader
> >would probably be to long for the mailing list, but here is the
> >interesting part:
> >
> >[...]
> >The full reader can be found here:
> >https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py
> 
> Good.
> 
> I tried to review your code 3fe08f9b:git-read-index-v5.py and
> compare it to your file spec f858cf6a9:Index-format-v5.textile.  I
> have the following comments (some of them already discussed in IRC):
> 
> 1. Your script seems to be reading a different version of the file
> than described in the spec.  [When I mentioned this on IRC you
> pushed a new version a4ee558ea of the spec.]
> 
> 2. Your script seems to assume that the index file has no
> extensions. It would be better (for documentation purposes and to
> ensure that there are no surprises) to make sure that the code knows
> how to handle extensions.
> 
> 3. Please document briefly how the scripts should be used.
> 
> 4. Please limit line length to 80 columns (like the main git project).
> 
> 5. Python has a nicer way to initialize dictionaries whose keys are
> all valid identifiers; for example:
> 
> -        return dict({"signature": signature, "vnr": header[0],
> "ndir": header[1], "nfile": header[2], "next": header[3]})
> +        return dict(signature=signature, vnr=header[0], ndir=header[1],
> +                    nfile=header[2], next=header[3])
> 
> 6. Some of your print statements are just begging to be written
> using string interpolation; e.g.,
> 
> -        print d["pathname"] + " " + str(d["flags"]) + " " +
> str(d["foffset"]) + " " + str(d["cr"]) + " " + str(d["ncr"]) + " " +
> str(d["nsubtrees"]) + " " + str(d["nfiles"]) + " " +
> str(d["nentries"]) + " " + str(binascii.hexlify(d["objname"]))
> +        print ("%(pathname)s %(flags)s %(foffset)s %(cr)s %(ncr)s "
> +               "%(nsubtrees)s %(nfiles)s %(nentries)s " % d
> +               + str(binascii.hexlify(d["objname"])))
> 
> printheader() can be rewritten similarly.
> 
> 7. You have a couple of while loops that would be easier to read if
> written as for loops.
> 
> 8. There is no need to use global variables.  Global variables have
> lots of disadvantages, one of which is that it is hard to tell what
> functions have side effects via the global variables.  It is better
> to pass the needed variables explicitly to functions that need them.
> 
> 9. ...after you eliminate the global variables, you will see that
> the checksums are mostly needed over limited areas of code then can
> be discarded.  Rewriting the checksum handling in this way would
> make it easier to see exactly what range of bytes is included in a
> particular checksum.
> 
> 10. There is no need to keep track of all of the data that will go
> into a checksum.  The CRC32 checksum can be computed incrementally
> via the second argument of binascii.crc32(data, crc).  Therefore,
> you only need to retain a 32-bit running checksum instead of the
> filedata array of data strings.
> 
> 11. It is bad style to generate output from within the
> readindexentries() function.  Given that it reads the whole array of
> file entries anyway, it would be cleaner to return the array to the
> caller and let the caller print out what it wants.
> 
> 12. Your handling of checksum errors is inconsistent.  In some
> places you generate exceptions; in another you simply print an error
> to stdout (not stderr!) and proceed to use the corrupt data.
> 
> 13. It is probably clearer to unpack the tuples returned by
> struct.unpack() directly into local variables with meaningful names
> instead of carrying them around as a tuple; e.g.,
> 
> -    header = struct.unpack('!IIII', checksum.add(f.read(16)))
> +    (vnr, ndir, nfile, next) = struct.unpack('!IIII', fread(16))
> 
> 14. It is more correct to check the file signature and version
> explicitly before plowing into the rest of the file (that's what
> they're there for!)
> 
> That's as far as I've got.
> 
> Michael

Thanks a lot for your feedback. I've now refactored the code and
thanks to your suggestions hopefully made it simpler and easier
to read. The reader should now read exactly the data from the
spec.
