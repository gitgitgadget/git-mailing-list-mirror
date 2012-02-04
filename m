From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 3 Feb 2012 22:49:42 -0800
Message-ID: <20120204064942.GD2477@tgrennan-laptop>
References: <7v8vkjl24d.fsf@alter.siamese.dyndns.org>
 <D140688E-B86C-4A67-9AD6-56160C26884D@ericsson.com>
 <20120204050818.GA2477@tgrennan-laptop>
 <7vsjirjhp7.fsf@alter.siamese.dyndns.org>
 <20120204055656.GC2477@tgrennan-laptop>
 <7vhaz7jf1d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:49:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZRb-00047v-QY
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab2BDGts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 01:49:48 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60879 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab2BDGtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 01:49:47 -0500
Received: by vcge1 with SMTP id e1so3068318vcg.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 22:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jLyP8hoc+bKrUG+5g9gceFzZmSpvR5s/KbDk1I/TEJY=;
        b=MOt8hyLlvS0vc9lD1Dmi2X1WQhT2h6hOPIPt4zPEc8inDIUH0XSQJF35pCQS8OL3Ln
         wP4JCsOy/z7DHiXcobHm6J1EZGHcKnDGbj4WdnUmWxDiywLOdvbxr9afw7qcDWR7RgPc
         DHA+fT3jJJzCb6HTQ7acS3fi/fN+pK7SxMucU=
Received: by 10.220.156.199 with SMTP id y7mr6175049vcw.2.1328338186802;
        Fri, 03 Feb 2012 22:49:46 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id h2sm5323867vdi.18.2012.02.03.22.49.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 22:49:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhaz7jf1d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189852>

On Fri, Feb 03, 2012 at 10:20:14PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> On Fri, Feb 03, 2012 at 09:22:44PM -0800, Junio C Hamano wrote:
>>>Tom Grennan <tmgrennan@gmail.com> writes:
>>>
>>>> Wouldn't you want Shawn and Jeff to tag the object (commit, tree, or
>>>> blob) that you had tagged?
>>>
>>>No.
>>>
>>>We _designed_ our tag objects so that they are capable of pointing at
>>>another tag, not the object that is pointed at that other tag.  And that
>>>is the example usage I gave you.
>>>
>>>The statement by Shawn and Jeff, "This tag is Gitster's" is exactly that.
>>>It was not about asserting the authenticity of the commit. It was about
>>>the tag object I created.
>>
>> Hmm, how about "git verify-tag [[-v] [--to]] <tag|object>"?
>> With "--to", all tags to the given tag (or object) are verified.
>> Without "--to" just the given <tag> is verified.
>>
>>>>    gitster$ git verify-tag --pointed v1.7.10
>>>>    tag v1.7.10: OK
>>>
>>>Just saying "$name: OK" will *never* be acceptable. "A signature made by
>>>any key in my keychain is fine" is not the usual use case. At least the
>>>output needs to be "Good signature from X".
>>
>> OK, I'll have to play with the gpg --verify-options.
>
>If it wasn't clear enough from my other message, I would rather not to see
>any change to --verify codepath as the first step.  Don't you think that
>the simplest and cleanest first step is to add --points-at to the list
>mode, so that with help from "| xargs git tag -v" you can bulk-verify
>without any other change?

No, I missed that. So you're suggesting,
git tag [-n[<num>]] -l [--contains <commit>] [--points-at <object>] [<pattern>...]

If so, I'll look into it tomorrow.

thanks,
TomG
