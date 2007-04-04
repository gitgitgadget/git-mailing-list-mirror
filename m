From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 15:40:58 +0100
Message-ID: <200704041540.59977.andyparkins@gmail.com>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 16:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ6ff-0007fH-V2
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 16:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbXDDOlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbXDDOlI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 10:41:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:23539 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbXDDOlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 10:41:06 -0400
Received: by mu-out-0910.google.com with SMTP id g7so315087muf
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 07:41:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NWiX4g1VvPiRo8PdFfLOsRKvakX+LN02DbCiBuhAPY3yDu37a3eicA74NNilIWlVFhWyB+k92+jSbvHrYaKbvW0ht29b8loBYq7yLvOtZBWnmnaFi1kstAVpn/yZRwoWn2+69LZoRXdqzZEtWwpOoAtqymRo65icCKv8rNhuot0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JGDp7L0g8utOQ+pz3cru0DDu0ToXam6ZcgDmPS/Z7F81xMTUzv+Z6o5iG2Yjh2aD0PP1AEjxTIPjQfhZItk2pBRzg6vY/X51ZIPnoNjUXwMJvRuLKEbjb7OmUyBs3c9XnzIpEICtUoaHdZcNOL+WYHFVPGZ8cxPP9xfSLcW+K+Y=
Received: by 10.82.186.5 with SMTP id j5mr830944buf.1175697664760;
        Wed, 04 Apr 2007 07:41:04 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm1386726ika.2007.04.04.07.41.03;
        Wed, 04 Apr 2007 07:41:04 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <4613A974.60808@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43742>

On Wednesday 2007 April 04 14:34, Rogan Dawes wrote:

> Well, how about my comments in <45E67978.9030805@dawes.za.net>,
> suggesting that the edit difference (number of steps required to
> transform one to the other) would be a better indication?

Perhaps.  There is certainly a difference between:

 somefile.bin  | 1000 -> 1000 bytes

and

 somefile.bin  | 500 bytes removed, 500 bytes added

> I think it is better because it is consistent with what we currently do
> for text files: show the number of lines added/deleted.

The thing is, "lines" is an understandable unit for a text file, so it's 
useful to show.  I'm not sure the same is true of "bytes" for a binary file.  
Those bytes could represent anything; the true unit of a binary file is 
dependent on its type.

> For binary files, it would be consistent to show the number of bytes
> added/deleted. I have not investigated the output format for the
> libxdiff binary patch format, but hopefully it would not be too
> difficult to calculate the deletions and additions.

I'm inclined to agree with Johannes, while it's certainly something 
that /could/ be shown - is it more useful?  There is no guarantee that a 
small change in the underlying content is represented by a small change in 
the binary diff.

As an example: compress a file, change a byte, compress it again, perform a 
binary diff; what is that diff telling you about the change?  (My answer is: 
not much).


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
