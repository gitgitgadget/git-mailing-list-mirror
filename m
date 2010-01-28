From: William Pursell <bill.pursell@gmail.com>
Subject: Re: shared permissions on COMMIT_EDITMSG
Date: Thu, 28 Jan 2010 07:03:45 -1000
Message-ID: <4B61C371.4050903@gmail.com>
References: <4B61569A.1010808@gmail.com> <20100128111425.GA29577@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Jan 28 18:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaXmv-0000iC-O3
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 18:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab0A1RD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 12:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755648Ab0A1RD4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 12:03:56 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:37334 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0A1RDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 12:03:55 -0500
Received: by bwz27 with SMTP id 27so683346bwz.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1l4gTlngF9D+3wV2SgYOcu5vnRBv8EgYTD4FaOMP0jY=;
        b=gj7wIrcLMQdyWoYFfFfvb++9mJ2Hj4yg0o4CgKXmcYOZxjyWUaPCZ8EF/o+vtanD9J
         ++Wo3lQvgxgz3yAnYknUHBTAT8gB89LWYpE6+m9DoFAo6EFe364qWryD8UG0hGP0nrF8
         YLOsjkQTjEAlN1yhPOiKkULv+NR8VORWyyHXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AHq3sifUCemSiTRE0GhHj+lOZbdg8V0jsxQDjJCLwdQx8SNVJ0dyWfD/SszndkZPhO
         H16Edxp6wHs0TdFpZDQAFffDbJLZXYolYj/qLcBIWFfeO1clzBoNCWPadXwCr9tsZNBJ
         yjernTvjEPSMND+KgIHDVIiDaaINz+V5w3LtA=
Received: by 10.204.25.82 with SMTP id y18mr1551528bkb.137.1264698233035;
        Thu, 28 Jan 2010 09:03:53 -0800 (PST)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id 13sm521656bwz.10.2010.01.28.09.03.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 09:03:51 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <20100128111425.GA29577@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138259>

Ilari Liusvaara wrote:
> On Wed, Jan 27, 2010 at 11:19:22PM -1000, William Pursell wrote:
>> With git-init --shared=0660 and a umask of 022,
>> the first commit to the repository creates
>> the file COMMIT_EDITMSG with mode 0644
>> instead of 0660.  I believe this is incorrect
>> behavior.  Simple fix:
>  
> COMMIT_EDITMSG is related to committing, committing needs
> working copy, and shared working copies don't work all too
> well (and Git can't do anything about that because all kinds
> of stuff edits the files there, not just Git).
> 
> Shared repository settings are meant to override umasks
> for files in actual repository itself.

For simple work flows (eg recording linear history
of config files), sharing a working directory
works okay except for COMMIT_EDITMSG.  Since
COMMIT_EDITMSG is in the git repository and only
written by git, it makes sense for core.sharedrepository
to be honored.

-- 
William Pursell
