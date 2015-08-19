From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] untracked-cache: fix subdirectory handling
Date: Wed, 19 Aug 2015 18:39:37 +0700
Message-ID: <CACsJy8DUUmT0xvBtMiC41qt+f=a02W1F-+i5gWjounNmpLA1tQ@mail.gmail.com>
References: <1439702227-15453-1-git-send-email-dturner@twopensource.com> <CACsJy8C=rnqrJHqMBSQcBsD1ihSvztVCnQ46N2mzoeh=HFM6qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 13:40:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS1j7-00066E-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 13:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbbHSLkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 07:40:08 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37491 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbHSLkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 07:40:07 -0400
Received: by igui7 with SMTP id i7so3543779igu.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OQzNMpjbIn57r6hbqqYgMufAdxrISQAdjjdl4nyYujY=;
        b=0KoskzgZtsKKihgHJnyKVxxxNBF580gjonU13COFfmTLDXgYwVo5AYnN3IilUgKokA
         JL+biwBhjgR94+aE+AvYvMn/lxWDG58t34vLFQN0gKXS2WEVmUleJNCRmwN3aMLCKxMW
         Ok78nVbMLZK+0aBQnaNpEMmxJ5u0hHag7zHkDIIymJMXhDPtmwupZuPjEIuq6fdvrvhy
         OcOMkZkZy26FU71T4yUlFGFr9vMB+k20wToHFq2AYUqxCvR2VmtEFEVhtmXMN37MrbMN
         Szq0Z0EQ7AbEyy8bl7FuVs4btAEg2qC3fg6nQubd/GWrTEZGmehLADKjTAXVOsfVWgHv
         oGaA==
X-Received: by 10.50.79.196 with SMTP id l4mr25965544igx.48.1439984407225;
 Wed, 19 Aug 2015 04:40:07 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Wed, 19 Aug 2015 04:39:37 -0700 (PDT)
In-Reply-To: <CACsJy8C=rnqrJHqMBSQcBsD1ihSvztVCnQ46N2mzoeh=HFM6qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276168>

On Sun, Aug 16, 2015 at 7:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Aug 16, 2015 at 12:17 PM, David Turner <dturner@twopensource.com> wrote:
>> Previously, some calls lookup_untracked would pass a full path.  But
>> lookup_untracked assumes that the portion of the path up to and
>> including to the untracked_cache_dir has been removed.  So
>> lookup_untracked would be looking in the untracked_cache for 'foo' for
>> 'foo/bar' (instead of just looking for 'bar').  This would cause
>> untracked cache corruption.
>>
>> Instead, treat_directory learns to track the base length of the parent
>> directory, so that only the last path component is passed to
>> lookup_untracked.
>
> Your v2 also fixes untracked_cache_invalidate_path(), which is not
> included here. Maybe it's in another patch?

No I was wrong. Your changes and the original code are effectively the
same (I misread strrchr as strchr). But I think there's a bug
somewhere as I'm writing tests to understand that code..
-- 
Duy
