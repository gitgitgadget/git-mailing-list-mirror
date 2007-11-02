From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg branch --create test v2.6.24-rc1 doesn't work
Date: Fri, 2 Nov 2007 09:24:59 +0000
Message-ID: <b0943d9e0711020224q6e4b6acn5879183dd14b6fff@mail.gmail.com>
References: <cc723f590710260342t5fd0bdc3nc1ea5198cea1a604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com, "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InsmC-0000RU-Iz
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbXKBJZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbXKBJZC
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:25:02 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:64412 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbXKBJZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:25:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so754127rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JGVqMv+WdY8yndMBNLc3l5uX/oWD2kj0+ehJ3IgEMF8=;
        b=C8P7MWF+W+djPtl5i4DZ3FJgq2ONsR/w6UHse7QL2uoYw66BeTwlD5O4jlhB4HHFvx7pWU9FTbXXdoclEdS41EDQuRQvcgLwu9AawKbvnz2xlM3iaWffNBFzojAcAqf7flhV1UPOv1s/s7MyRk6dn9XUjbuYEoE4/6oSRwVm9iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JmPUTS4rXR+mM8UF+UctEjKLWP5a51URPZ92TFhMMXmymBBT5oUvOOeTZnX8R2RvZM0V8pZPXx0GwsqmjkFwnBBWv/aIa+xSHGyjyzzGbKIJLsm6gSHtu8pO2LABrDyQ5aPrrUH2+tQ3kqzH6Z2Rd89DqEYTPA4XpCYtYFhqNIg=
Received: by 10.141.36.10 with SMTP id o10mr767587rvj.1193995499715;
        Fri, 02 Nov 2007 02:24:59 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Fri, 2 Nov 2007 02:24:59 -0700 (PDT)
In-Reply-To: <cc723f590710260342t5fd0bdc3nc1ea5198cea1a604@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63082>

On 26/10/2007, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> $ stg branch --create test v2.6.24-rc1
> Checking for changes in the working directory ... done
> Don't know how to determine parent branch from "v2.6.24-rc1"
> Branch "test" created
[...]
> [test@linux-review-ext]$ stg import
> /home/opensource/patches/ext4-patch-queue/ext4_mballoc_freespace_accounting_fix.patch
> Checking for changes in the working directory ... done
> fatal: cebdeed27b068dcc3e7c311d7ec0d9c33b5138c2 is not a valid 'commit' object
> stg import: git-commit-tree failed with code 128

The problem is that a tag id is used as the head of the stack rather
than the corresponding commit id. I modified StGIT to get the commit
id (and, as I said, you can work around this in the meantime by
passing "v2.6.24-rc1^{commit}" to the branch command).

I'll push the changes tonight but I have to solve the branch deletion
as it is left in an inconsistent state after import (and --force
should be able to deal with it but it doesn't).

-- 
Catalin
