From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Why SHA are 20 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 19:43:27 +0200
Message-ID: <e5bfff550704211043s40d33187jc334c1d85330132a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfJcR-0007GZ-Uv
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 19:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbXDURn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 13:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbXDURn3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 13:43:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:28233 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbXDURn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2007 13:43:28 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1170671wra
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 10:43:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MPy1cS+JLeh/+yi/nGd8PXtnXhycMgds3sw9hrnviQ9qEPHoyuan6OJmU479u1UpkGA9xF9AF/qdkKGkVPA6B1hiDqUaupG1InWE4Jdlha7ptXPzzrIjw/kdPPsxbXzzL1l3zvV98AeuzNXsJ+1mVmkReo2KVJ2t6bDMpMDy4U4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tc035XA61irkTCOgnh0uyXXKDAgU2RFjsXXBc64hWuvmdpZwxz5WHJGg5I/998sO6qKyC/1FbhfypswYbwCHjHGmmKgIM5mzw8kBanPzN7tH+3zqiQWko+VUxDSOJ3KvdJqtLSHY514VxqKFbGcKcgxFViBFm/FCf+TEaib+DJs=
Received: by 10.114.176.1 with SMTP id y1mr1781525wae.1177177407160;
        Sat, 21 Apr 2007 10:43:27 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 10:43:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45185>

On 4/21/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> Well, any hash is "incomplete" or "not long enough" inasmuch as it's
> theoretically possible to find collisions. The choice of the full 160
> bits (note: this is 20 bytes, not 40) is arbitrary -- it's just "long
> enough". 128 bits would have been enough to prevent any naturally
> occurring collisions, too (maybe even 96 bits would be enough, I'm to=
o
> lazy to do the math). The only reason to go as high as 160 is to
> prevent any possible collision created by a malicious adversary, too,
> so that it's possible to e.g. sign just a commit and be able to trust
> everything it points to. The SHA1 designers felt that 160 bits was a
> good compromise between size and robustness, and we just trust that
> their (and the cryptographic community's) guess is good enough.
>

I think it is sensible to differentiate between

- creation of a 160bits possible unique signature

- use of whole 160bits signature to reference the object

I'm wondering that as long as we are able to calculate on the fly the
whole 160 bits signature from the object when needed then the second
point _could_ be relaxed and we could use a truncated sha (note that
is not a new sha calculated with less bits, it is the good old 160bits
sha just trucated to be used as object reference).

This could be convenient as long as collision is very unlikely, so to
work almost always with abbrev forms and fallback on full 160bits on
those rare cases.

  Marco
