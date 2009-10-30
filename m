From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Fri, 30 Oct 2009 11:25:25 +0000
Message-ID: <3f4fd2640910300425q602471a6v1111a7dceee7746c@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <200910300202.02016.markus.heidelberg@web.de>
	 <76718490910292000t7b024b83y68d71b6ff810c15@mail.gmail.com>
	 <200910301135.59831.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Oct 30 12:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3pcH-0000Sa-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 12:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbZJ3LZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 07:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756045AbZJ3LZW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 07:25:22 -0400
Received: from mail-vw0-f192.google.com ([209.85.212.192]:43638 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477AbZJ3LZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 07:25:21 -0400
Received: by vws30 with SMTP id 30so589570vws.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=/+ABiZWY2/tDh394wFe8N5ucnd1j4cKyR0za7dCZToE=;
        b=KiANJyUhXwbHVk6nZ1tKkBIW1lDwWr/ZqTgZswSpwrUf7eIHpuquW61oPWsp/YBH3H
         rvGljvA2XMnSo+yF5RTD76f+o9Kq1+dpabFDnzx2uW6c4x+Z9RLqbunN6wlhkQsZchH3
         /7tCmNAfU+/jNzDNPda3Cml+xPT2kCq4+qRAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SvbjyhydE3qGC0+FEJQPHlzoc3U+FiCykWbcmN1PieJYxiSAZKG1GRl/vA2BSiBVkE
         6WpQnNn8/9XHeuWW+tSvVtWUSvg5QKF9plv5v96antvj7lMi0D9PXyWcpL9/5oOkIZ8j
         qa5+XVrmuywj4IobI5cxCQ4TZzGyrBbAqQSBo=
Received: by 10.220.126.224 with SMTP id d32mr1148744vcs.57.1256901926042; 
	Fri, 30 Oct 2009 04:25:26 -0700 (PDT)
In-Reply-To: <200910301135.59831.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131696>

2009/10/30 Markus Heidelberg <markus.heidelberg@web.de>:
> Jay Soffian, 30.10.2009:
>> On Thu, Oct 29, 2009 at 9:02 PM, Markus Heidelberg
>> <markus.heidelberg@web.de> wrote:
>> > He didn't mean p4merge on other platforms, but other merge tools on Mac
>> > OS X. What about all the other merge tools already in mergetool--lib?
>> > Should they get special handling, too?
>>
>> If someone wants to scratch that itch, then yes. The default diff tool
>> for OS X has its helper already in /usr/bin (opendiff). p4merge is
>> arguably a better merge tool, and it installs as an app bundle in
>> /Applications. I'm not sure about the other diff tools, I haven't
>> looked.
>>
>> > And for Windows we could add C:\Program Files\MergeToolX\tool.exe for
>> > every merge tool.
>>
>> If it makes those tools easier to use with git, and if someone on
>> Windows wants to scratch that itch, then yes, we should.
>
> Another possible problem: the user can change the installation
> destination on Windows. What's the behaviour of Mac OS here? Is the
> instalation path fixed or changeable?

For Windows, the program should have an InstallDir or similar registry
value in a fixed place in the registry to point to where it is
installed (something like
HKLM/Software/[Vendor]/[Application]/[Version]).

As for Linux, there is no guarantee that things like p4merge are in
the path either. It could be placed under /opt/perforce or
/home/perforce.

What would be sensible (for all platforms) is:
  1/  if [difftool|mergetool].toolname.path is set, use that (is this
documented?)
  2/  try looking for the tool in the system path
  3/  try some intelligent guessing
  4/  if none of these work, print out an error message -- ideally,
this should mention the configuration option in (1)

(3) is what is being discussed. It is good that it will work without
any user configuration (especially for standard tools installed in
standard places), but isn't really a big problem as long as the user
is prompted to configure the tool path. Also, I'm not sure how this
will work with multiple versions of the tools installed (e.g. vim/gvim
and p4merge).

- Reece
