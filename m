From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 10:04:55 +0100
Message-ID: <e1dab3980808140204t29b56fa4h3b22e52fc576fb1e@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <87vdy71i6w.fsf@basil.nowhere.org>
	 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
	 <20080813031503.GC5855@spearce.org>
	 <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
	 <alpine.LFD.1.10.0808131036590.4352@xanadu.home>
	 <m363q5t152.fsf@localhost.localdomain>
	 <20080813150425.GC3782@spearce.org>
	 <e1dab3980808130826m4870df3ctf09ecf0062ef6e7c@mail.gmail.com>
	 <46a038f90808131654r228a1b57y964f7cdb9c77be5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, "Geert Bosch" <bosch@adacore.com>,
	"Andi Kleen" <andi@firstfloor.org>, "Ken Pratt" <ken@kenpratt.net>,
	git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 11:06:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTYmq-0004xG-Jk
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 11:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758614AbYHNJE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 05:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758541AbYHNJE6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 05:04:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:5168 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758374AbYHNJE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 05:04:56 -0400
Received: by wf-out-1314.google.com with SMTP id 27so578924wfd.4
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dX0smNaBTAyTem9WPmW0CHJTguD14T5oeNPWo/rgbX0=;
        b=UgOeK491z77H5/YdPqw7HKQwuKwBewPx8GgAb4d/b/dqD0ttn7KlfqodTu5KC5se1D
         zpya9rbquK5PwgA1MpOb9n53mT3hq9u+YgRIB7vJR4kb+yG7VLVIB8QagGxWHO92gSRb
         jHv6Io090stcsN+4sbghj+NNigfY7K1oHe4D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JeFEphi5JrPhWK+OwG9hhXtdaIOnEwZmtgXD1wTJN+O2xOTyv4mQJHvP1wDF+jAkKC
         KvRL9hIGwTjcjcrjqUxZDWkRPL/IfR0HXPhGy3iwXYXvpt4McQ1fbyzEWdTAjxrIg3RG
         poTPz6ualyjfGR78Vi2fePLZttqQalxzvaD9Y=
Received: by 10.142.157.15 with SMTP id f15mr394039wfe.186.1218704695293;
        Thu, 14 Aug 2008 02:04:55 -0700 (PDT)
Received: by 10.142.233.14 with HTTP; Thu, 14 Aug 2008 02:04:55 -0700 (PDT)
In-Reply-To: <46a038f90808131654r228a1b57y964f7cdb9c77be5f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92338>

On Thu, Aug 14, 2008 at 12:54 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Aug 14, 2008 at 3:26 AM, David Tweed <david.tweed@gmail.com> wrote:
>> FWIW, PDF format is a mix of sections of uncompressed higher level
>> ASCII notation and sections of compressed actual glyph/location data
>
> The PDF spec allows compression of the "text" sections - if a PDF is
> uncompressed, it's a good candidate for delta & compression.
> Unfortunately, within the same file you might have an embedded JPEG.

Sure, all I was pointing out was that even pdfs with compressed page
contents can look like uncompressed text from looking at the entropy
of the first 4k or 8k.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
