From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] rehabilitate 'git index-pack' inside the object store
Date: Tue, 21 Oct 2008 21:57:04 +0700
Message-ID: <fcaeb9bf0810210757w1c14e0a3x1eb61a589a089f10@mail.gmail.com>
References: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 17:00:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsIgh-0005OL-Qr
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 16:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbYJUO5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 10:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYJUO5H
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 10:57:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:13626 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYJUO5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 10:57:06 -0400
Received: by ey-out-2122.google.com with SMTP id 6so784229eyi.37
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7bvgImIAlOmzSh5uBIqbYAhSRtut3dbLkYnxGZX0zrQ=;
        b=LaZGNLhQguejFpgWsuh28EgtY0oV4ju5IJwgQRoU3QUT/widFLIEGbg0ZYtgSUg2tf
         /OQH1sXr9fZOXjW5gDwlJsnPEadJtFUpvnpT7qvRq8CCTA97Yl7odsJFPBhc2p6kO2VI
         DhJ63pAgMWXR22gP01SXCZ09LlUgkZbiQlQys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d+SlAGpfKDb9hc9wo6Y8vMvL4wbsSwJ/oIQYa7fKFny0oRH+YsZj2RURbztcCiGPgW
         ESfK2k6x8exzdl9z3bxScCfw/vSczTmiXvp00Nj3kOkLUTEkYnc6fyWJDeoBjKgfkW7z
         7HBf7X9WE4IvoceOW3nSyrrBuGo6TEik7mY4s=
Received: by 10.86.92.7 with SMTP id p7mr8095771fgb.8.1224601025052;
        Tue, 21 Oct 2008 07:57:05 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Tue, 21 Oct 2008 07:57:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810202110380.26244@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98788>

On 10/21/08, Nicolas Pitre <nico@cam.org> wrote:
> Before commit d0b92a3f6e it was possible to run 'git index-pack'
>  directly in the .git/objects/pack/ directory.  Restore that ability.

I am sorry I did not catch this in the first place. While the fix
should be fine for "git index-pack". I wonder what can happen for
other setup_*_gently()'s consumers. Other commands may be affected too
(e.g. running "git apply" or "git bundle" from inside .git). Maybe we
should let setup_*_gently() do read-only stuff only and let its
consumers to handle cwd. I recall Jeff has plan about worktree setup
rework, though could not find the thread. Will think more of it
tomorrow.
-- 
Duy
