From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 10 Feb 2012 19:33:41 +0700
Message-ID: <CACsJy8DnqYZ5CdZqbebWS4NS85mfwumyao0abeqDxMXrHhDELA@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 13:34:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvpg9-0001jl-PA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 13:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab2BJMeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 07:34:13 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50088 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2BJMeM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 07:34:12 -0500
Received: by wics10 with SMTP id s10so1974505wic.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 04:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pEKGEWWXKbQ2fmQEnuWNpMBL9AguPCvbh6fwe+Ysefw=;
        b=k48/zh1Cp5nLzMt1cOpqehfHZg0QLMMokOPCm4gqyWJDaBO/V3Dm7G+VGesmRRDirN
         ULS2qOUL8vcbDE8mEeOYPjA7T6zQ/Wpzr9r7slGKtb/TQbCgUmaMWFav2p1kHkVp/pHF
         Rg+OAWEAdMXhf8vwN1egVqUcYTJaIAyDPQZ4g=
Received: by 10.180.19.97 with SMTP id d1mr9026635wie.12.1328877251239; Fri,
 10 Feb 2012 04:34:11 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 10 Feb 2012 04:33:41 -0800 (PST)
In-Reply-To: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190403>

On Fri, Feb 10, 2012 at 4:42 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Hi,
>
> I compared stating whole tree vs one small subdirectory, and I
> expected that for the subdirectory status will be very very fast.
> After all, it has only few files to stat. But it's not fast. Why?

Because stat'ing is not the only thing git-status does? In order to
find out staged changes, unstaged changes and untracked files, it has
to do the equivalence of "git diff --cached", "git diff" and "git
ls-files -o". I think copy detection is also enabled, which uses more
cycles.

Profiling it should give you a good idea what parts cost most.
-- 
Duy
