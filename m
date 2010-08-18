From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: BUG?: git-apply sometimes says "corrupt patch" when adding single lines
Date: Wed, 18 Aug 2010 11:15:31 +0200
Message-ID: <AANLkTimSnKxMpYZ263muV4nE-ppfWXfpM6SEo4HKAB66@mail.gmail.com>
References: <AANLkTineHiG9vCpbJzJ2x9CFjZ7LQeExs7cN5YhoZhft@mail.gmail.com>
	<4C6B8BC8.9050301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 18 11:15:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlekE-0004pa-Tk
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab0HRJPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 05:15:34 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61749 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab0HRJPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 05:15:32 -0400
Received: by pxi10 with SMTP id 10so134267pxi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=uBTO55v7vseGKq75601T9+gaojoyGqCfaOYR9MTgNbE=;
        b=vW8ZTI9T+e2+GXqypEa/pMhsIhhke3X+vZ6QAz0oSygrkUqc+hwc52oYwxfohuNnlY
         JRUU/dZ6gi3aMVxlmVLt0Ebh4oODafa8ZFImcYibMK3Q/5UrizIavcqmJZp2GhA86d6a
         Hb41sPN1gvEhkjNRBc7xiQH5XXyqHQZ2mWxjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UeapXuW5UFduUwgc3LQ8UTcEy7aM7SgsG4Irjo6ZMuSWSSdhC/HFWSMcg+SA6Str7B
         iQOO9deJxh2ivY9N9NtyiLr3CtPtjEeY7mS254m0t5SlbKWpU1n0F4WizsrHA80w2Kgr
         u+EW5dawwKC0ZnS/ogRpjOmaEcABGPsa2Y+yE=
Received: by 10.114.36.4 with SMTP id j4mr9273793waj.176.1282122931701; Wed,
 18 Aug 2010 02:15:31 -0700 (PDT)
Received: by 10.114.147.16 with HTTP; Wed, 18 Aug 2010 02:15:31 -0700 (PDT)
In-Reply-To: <4C6B8BC8.9050301@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153820>

On Wed, Aug 18, 2010 at 9:29 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/18/2010 1:27, schrieb Tor Arvid Lund:
>> I often use git-gui when staging commits, and I noticed that if the
>> file I'm working with has a:
>>
>> \ No newline at end of file
>>
>> ... as the last line of the diff, and I try to "Stage lines for
>> commit", then git-gui (or really git-apply, as I understand it) says
>> that I have a "corrupt patch at line <so-and-so>".
>>
>> Is this a bug? Or is it maybe git-gui that sends something wrong to
>> git-apply? I don't know... :-/
>
> This is really a bug in git-gui, not in git-apply: The big while loop in
> lib/diff.tcl, function apply_range_or_line, must be taught about "\ No
> newline...".

Ok, thanks for tracking it down. I suspected this, since the tests for
git-apply seemed to have example patches for "\ No newline...".
Ultimately, this doesn't scratch me enough that I want to learn (or
guess) how to fix the Tcl stuff...

-Tor Arvid-
