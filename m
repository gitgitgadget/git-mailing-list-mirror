From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Fri, 18 Jul 2014 17:19:08 -0700
Message-ID: <20140719001908.GX12427@google.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
 <20140717221056.GO12427@google.com>
 <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com>
 <20140718022208.GQ12427@google.com>
 <50047EE8-4EF8-49E3-9067-1C88B2FB9D58@gmail.com>
 <20140718171635.GR12427@google.com>
 <DC1EBA8C-1443-42DA-BA96-CB38D13502ED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 02:19:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8IMu-0003K5-I6
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 02:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbaGSATM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 20:19:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60004 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbaGSATL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 20:19:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so6261517pad.27
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YcJdpY3HclJCSiDR+f269lI6nxE/F/n0kqW1VU0bZog=;
        b=kkk4/r49PqAn5sOXJz60YuGK/UXZ5fwD5X5IX9zPD9kf8RMe5rk9efPTFyHKkjrjir
         g8fnH8oFPPx+LF8Pb+WVGDcHkh6xRN4A6sEjF/8q4CIeMe6K43mfAp27Gxm8/gr+fSz5
         ItGn+dtaRqBZAl7Hwt+cVmYpL+mXVBKmeka/+R8vG8et3DkOZBgOGH9Kt5DwC+EU/3KI
         mmIo9oJ/w3oz8P7CzFqnyFhQIpZtMWz1nQpHMN/u4FCdy9aVtCx2vArgfiepfLjaDQeC
         +b/KXpzJHaY/AZEjuQeKYVdmdAm4TBGjES0W0VB5XGyX03VYCez7xNPgcrmxsiEa8ps9
         /7gQ==
X-Received: by 10.68.163.100 with SMTP id yh4mr9132059pbb.122.1405729151078;
        Fri, 18 Jul 2014 17:19:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:6d3d:4f:6892:efc2])
        by mx.google.com with ESMTPSA id pz10sm6759288pbb.33.2014.07.18.17.19.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 17:19:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DC1EBA8C-1443-42DA-BA96-CB38D13502ED@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253860>

Kyle J. McKay wrote:
> On Jul 18, 2014, at 10:16, Jonathan Nieder wrote:
>> Kyle J. McKay wrote:

>>> You might also want to take a look at [1] which suggests that when
>>> doing SRV lookups for URLs they should be done regardless of whether
>>> or not a port number is present (which then eliminates the RFC 3986
>>> issue the current SRV lookup code has).
>>
>> "Git URLs" as described e.g. in git-clone(1) weren't intended to be
>> actual URIs.
>
> According to RFC 3968 section 1.1.3:
> "A URI can be further classified as a locator, a name, or both. The
> term "Uniform Resource Locator" (URL) refers to the subset of URIs"
> [...]
>
> So actually they are URIs.

You mean abusing the word URL when we meant URL-shaped thing makes it
into a URL?

>> What would be the interoperability advantage of making
>> them URIs?
>
> According to RFC 3968 they are already considered URIs.

I don't think you understood my question.

>> This has come up before, with e.g. people asking to introduce a
>> git+ssh:// and git+http://
>
> How is a discussion about changing the scheme name relevant to a
> discussion about treating a URL with an explicit default port the
> same as one without (which Git already does but stops doing with the
> 0010 git SRV patch)?

It's where the question of whether the things you pass to 'git clone'
are URIs came up before.

I don't understand what you want in this side-conversation.  Do you
mean that I should read that RFC and be convinced that what you are
saying about ports is the right thing to do?  I can easily be
convinced some other way, but "It's in a standard that you never
intended to follow" is not particularly convincing or relevant.

The same philosophy as the git project applies to POSIX conformance
issues applies here, too.  We live in the real world.

Hoping that clarifies,
Jonathan
