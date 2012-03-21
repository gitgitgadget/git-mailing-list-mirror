From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 16:43:15 +0100
Message-ID: <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com> <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com> <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com> <871uomrubl.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 21 16:43:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SANhN-0006kt-4k
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 16:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab2CUPnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 11:43:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42956 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab2CUPnb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 11:43:31 -0400
Received: by eekc41 with SMTP id c41so419267eek.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=nQ4mSgEppeCT6I2DBP43adYhUvJYQ01lERTc17t3BCg=;
        b=jcUzf5WjW12hogPPN5GuDbO6VRlhNmXzp0VGvXdfZ8HmU0HGt5QYDC5EVLtMySVBPi
         3Wg3tAUw3kgANdUfLyCALUxzFrIMEW5CPyv4Ryt4N72Gv75J+23v3sYsgbaiHsyVg3VF
         qLoKwORLX6zhaUPJlAwieRAFMP5VI0ooLFc1xFkKQmHZFQyCMXeKJBkHVO/CMgPn6rwH
         VjeyYLWa4sADQbBFD1WtgEX6FswUWXv+D5YVWe97zXRlZwRbBN2sppnTP8iM9D29vk7K
         K90WPlx/9SdHIDQu/yGwQLbT3DxvRQb6y6n6wN5QZwJmKbAbq5EKp/AMSFd6yc38ONf0
         lsBQ==
Received: by 10.14.95.12 with SMTP id o12mr617622eef.80.1332344609545;
        Wed, 21 Mar 2012 08:43:29 -0700 (PDT)
Received: from surfer-30-3-17.surfnet.iacbox ([95.171.52.81])
        by mx.google.com with ESMTPS id x8sm7181374eea.10.2012.03.21.08.43.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 08:43:27 -0700 (PDT)
In-Reply-To: <871uomrubl.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193583>


On Mar 21, 2012, at 1:51 PM, Thomas Rast wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> On Wed, Mar 21, 2012 at 4:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> 
>>> On Mar 21, 2012, at 2:29 AM, Nguyen Thai Ngoc Duy wrote:
>>> 
>>> However I got one more question, since I'm not yet really familiar with the
>>> code and internal structure of git, what exactly does the SHA1 over the
>>> index exactly achieve? Is it only for checking if the index is still correct
>>> for the next time it is used and has not been changed or is there a more
>>> important function of it?
>> 
>> It makes sure the index is not corrupt (by disk faults for example). I
>> don't think it is used for anything else. Cheaper checksum can be used
>> if good enough for the index. See
>> http://thread.gmane.org/gmane.comp.version-control.git/190016 and the
>> following reply.
> 
> Note that switching the checksum used already requires a
> backwards-incompatible change of the index format.  If we are going to
> do that, I'm somewhat opposed to not also revising it along the lines
> sketched by Shawn (at least).
> 
> See my reply to Elton Sky
> 
>  http://thread.gmane.org/gmane.comp.version-control.git/193550/focus=193571
> 
> for links to some threads you may want to look at.

While reworking the index into a tree (not to mention if it's in database format), 
the backward compatibility would be broken anyway from what I understood?
Therefore taking Shawns thoughts into account should not be a lot more work
and should make it also easier to implement for the .git reading programs,
since it's easier to parse for the core it should also be easier to parse for them.

Then if changing the checksum algorithm can bring some advantage I think
it should be well worth the extra work while we break compatibility in any case.

--
Thomas Gummerer
