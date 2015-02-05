From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/2] Makefile: Use the same source directory for "ln -s" as for "ln" / "cp"
Date: Thu, 5 Feb 2015 14:44:55 -0800
Message-ID: <0BAD0471-1070-4520-9D09-CA816DECD59C@gmail.com>
References: <CAHGBnuOGv4Zn7dz6voEMn=PtMfm=0TQumt9PxV9nYgXyB0Xj=g@mail.gmail.com> <D060A1E5-DAF3-49D5-B0B3-F831BCDFD41F@gmail.com> <xmqqmw4skvrn.fsf@gitster.dls.corp.google.com> <CAHGBnuP5e7NsDrD31otFGZiFYW-vxsOf7kV61=Zt32n3S78RBg@mail.gmail.com> <20150205195143.GB15326@peff.net> <4CF52072-713F-4456-B894-B874B0EFFC6B@gmail.com> <xmqqvbjgjcqw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 23:45:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJVAX-0004eJ-EF
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 23:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbbBEWpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 17:45:00 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62719 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbBEWo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 17:44:58 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so12842525pad.8
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 14:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=YbvNk7nZtcua01RFT1yX9Cl3WLvNJao0Pbv9hfTUuOM=;
        b=C0x1ZzrzJUx381xobd7YGPqjXUE2/OhEgR4eqE8o0LO0D8ZTFjf7oLgYsSlp40jJOU
         aOqIgvJEpc4fohvfVWCkZuNHTVBeqU1q+LVwsyUj5ou1eYgtqDUkBbGqT9Vwlq0tnDEV
         EwmiRuevuaUZAB6RaY8tL2no7BuXGCh4MGrkEkoCJy1pZCIBtH7cw/zxG8ToiyeCGAnX
         ElILr/gIJw6KCmwdHkf/lozuR+8ZcAMBweb1qvtl9AqACo1p96PoJJxaHYowyeXI+CS2
         imF/IAfDu4LDq9oSbsg/VMamPC03eGg0OErsUSfU0bzjGyeAGT+w6usJw4WYamNrd/jk
         cS+g==
X-Received: by 10.68.135.97 with SMTP id pr1mr721488pbb.71.1423176298305;
        Thu, 05 Feb 2015 14:44:58 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id mm9sm6024821pbc.76.2015.02.05.14.44.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Feb 2015 14:44:57 -0800 (PST)
In-Reply-To: <xmqqvbjgjcqw.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263410>

On Feb 5, 2015, at 12:59, Junio C Hamano wrote:
> I do not know (and I am not quite sure if I want to know) how
> serious your "potential" problems would be, and I do not doubt you
> know OS X quirks much better than I do and do not intend to argue
> there aren't such problems.  I am just curious how "user-facing"
> comes into the picture.

Suppose you have built and installed some software to /usr/local and  
it's ended up in the usual subdirectories, /usr/local/bin, /usr/local/ 
lib, etc.

Now you get an installer for package X, and to avoid stepping on  
things it installs to /opt/XYZ with the usual suspects /opt/XYZ/bin, / 
opt/XYZ/lib.  There are several of these that I'm aware of where XYZ  
is whatever package you're installing.

Now since /opt/XYZ/bin is not usually in one's PATH it installs a few  
select symlinks from /usr/local/bin/whatever to /opt/XYZ/bin/ 
whatever.  Not all of the /opt/XYZ installers do this, for some of  
them it's a selectable option.

So now we have:

# This one can be a relative or absolute symlink, doesn't matter
/usr/local/bin/foo -> /opt/XYZ/bin/foo

And we also now have this:

# A real binary, not a symlink
# Uses and locates libfoo with ../lib/libfoo.dylib
/opt/XYZ/bin/foo

# A real library binary, not a symlink
/opt/XYZ/lib/libfoo.dylib

So /opt/XYZ/bin/foo locates libfoo.dylib by using a relative path  
embedded within it (in this case it would be @loader_path/../lib/ 
libfoo.dylib).

So far, so good, right?

Nothing complicated going on.

But the user has built and installed an older version of libfoo  
already to /usr/local/lib/libfoo.dylib.

Ah-oh.

User attempts to run foo.

Shell finds foo at /usr/local/bin/foo and runs it.

The dynamic linker correctly loads /opt/XYZ/bin/foo and starts to  
resolve the dynamic library links embedded in it.

For the "@loader_path/../lib/libfoo.dylib" one it first tries /usr/ 
local/bin/../lib/libfoo.dylib rather than /opt/XYZ/bin/foo/../lib/ 
libfoo.dylib because /usr/local/bin/foo was the executable that was  
run and since the user has installed an older version of libfoo.dylib  
in /usr/local/lib, it finds and loads that instead of the intended  
one.  If it didn't find that it would then try /opt/XYZ/bin/foo/../lib/ 
libfoo.dylib and get the right one.

Sometimes you get an immediate error if the unintended library version  
is just too old to be compatible.  On the other hand, if it's just old  
enough to be buggy but not version incompatible now you're running  
with a buggy library or some other incompatibility that doesn't show  
up right away.

I think this is a nasty bug specific to OS X, the fact that it tries  
both paths though suggests it was deliberate.

I have not tested all versions of OS X to see if it might have been  
fixed in the latest, but there it is.

If you put /opt/XYZ/bin directly in the PATH this can't happen  
(provided /opt/XYZ/bin/foo is not itself a symlink).

So that's how a user-facing binary that is a symlink can cause  
problems.  I suppose it's not just limited to user-facing binaries,  
but that's where it tends to show up as it seems the non-user-facing,  
non-executable stuff usually has a sufficiently controlled surrounds  
that they're not vulnerable.

I say "user-facing" because the binary is found in the user's $PATH.   
I do not consider the libexec/git-core binaries to be user-facing  
since they are not normally in the user's $PATH but rather  normally  
accessed via the "git" binary which is likely in the user's $PATH.

In the case of Git, a /usr/local/bin/git -> ../libexec/git-core/git  
symlink should not be vulnerable to this problem, because even if the  
executable ends up with some relative dylib paths in it (usually not  
the case) when applied to /usr/local/bin they're unlikely to lead  
anywhere with user-installed libraries since git-core is one directory  
deeper than bin.

Anyhow, that's why I tend to avoid putting symlink-to-binary stuff in  
PATH.  In any case a packager can make adjustments to avoid the  
problem before creating an installer.

-Kyle

P.S.

On Feb 5, 2015, at 12:59, Junio C Hamano wrote:
>> I'm not sure exactly why, but I think:
>>
>> On Jan 30, 2015, at 13:10, Junio C Hamano wrote:
>>> That would make me feel dirty.
>
> That is a confusing style of quoting.  I suspect that I said the
> above in a totally different context.

But I've been dying to work that in somehow ever since I saw that.  ;)
