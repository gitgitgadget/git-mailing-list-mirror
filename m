From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 16:39:19 -0700
Message-ID: <44FF5C27.2040300@gmail.com>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 01:39:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL6zQ-0007Dm-Pj
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 01:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWIFXjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 19:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWIFXjX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 19:39:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:36757 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030251AbWIFXjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 19:39:22 -0400
Received: by nz-out-0102.google.com with SMTP id n1so7380nzf
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 16:39:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Z0MzP2qzSuoHoynZjrtl8nAz35nOvItbOGiiRuqwfmEHwY1Q9aRxTk18JLk3SJ2xGaUW8sdgejcDz2M27RZw35a8ljPosoI4ErBOsK0B1EN62/1LLOVunK7IRSCKsznpaN04I8gNcE6gwGiy769LGEWQeWcz6lWwRknK2QKaCqY=
Received: by 10.65.234.3 with SMTP id l3mr76112qbr;
        Wed, 06 Sep 2006 16:39:21 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id f16sm8658qba.2006.09.06.16.39.20;
        Wed, 06 Sep 2006 16:39:21 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26570>

Jon Smirl wrote:
> On 9/6/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
>> TREE objects do not delta or deflate well.
> 
> I can understand why they don't deflate, the path names are pretty
> much unique and the sha1s are incompressible. By why don't they delta
> well? Does sorting them by size mess up the delta process?

My guess would be the TREEs would only delta well against other TREE
versions for the same path.

> Shawn is doing some prototype work on true dictionary based
> compression. I don't know how far along he is but it has potential for
> taking 30% off the Mozilla pack.

Just looking at the structures in non-BLOBS, I see a lot of potential
for the use of a set dictionaries when deflating TREEs and another set
of dictionaries when deflating COMMITs and TAGs. The low hanging fruit
is to create dictionaries of the most referenced IDs across all TREE or
COMMIT/TAG objects.
