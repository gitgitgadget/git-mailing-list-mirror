From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] difftool: Handle compare() returning -1
Date: Thu, 26 Jul 2012 12:25:12 -0700
Message-ID: <CAJDDKr7xRL_bXOs5Ka2g9v=_AVpr7vzt3fd-5DYtiF_4gLE7QQ@mail.gmail.com>
References: <1343282878-86431-1-git-send-email-davvid@gmail.com>
	<1343282878-86431-2-git-send-email-davvid@gmail.com>
	<7vd33i733s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:25:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuTgW-0001R7-8M
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2GZTZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 15:25:14 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50449 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab2GZTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 15:25:12 -0400
Received: by vbbff1 with SMTP id ff1so2002696vbb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X0DtloM5oBa3izgXt+y4LbPI4wV0H2EnCspmr78mGK0=;
        b=IrtHQMI+59zF70cYr6+G5M9APEssuS/9NstDNSYEbqFMRWkWeTS8PsTIkR/mlyH3t8
         zF1A/M4rXAhapQqM1BVxqs/EtOq5vrcZGWye8dOoiT5g9sqeD/adP/N6jZebpXUFIsYz
         zFmmODr/McSexddrzl++7Beq1tLdAnPNQC1M/M7z1d161i1poRjnlFSaOsPQn3IGf2RP
         yTvuileQtQKGuUF2zhNakGbcOTZeQB3FOLWdjWpsT3voU0oOoyZ3MfTOYWMe8U/Sz6OP
         waK7/I3gItO3PyX7OYb8d5GELtyOpkzn5Ye+EVa0dRQXdi+70d0iDn4gm+3mZXvRQL+M
         Ac7A==
Received: by 10.220.154.148 with SMTP id o20mr13512750vcw.18.1343330712107;
 Thu, 26 Jul 2012 12:25:12 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Thu, 26 Jul 2012 12:25:12 -0700 (PDT)
In-Reply-To: <7vd33i733s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202294>

On Thu, Jul 26, 2012 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> +sub exit_cleanup
>> +{
>> +     my ($tmpdir, $status) = @_;
>> +     rmtree($tmpdir);
>> +     if ($status and $!) {
>> +             my ($package, $file, $line) = caller();
>> +             warn "$file line $line: $!\n";
>
> Are you sure rmtree() would not clobber $! before the code checks it
> here?

rmtree() calls croak() on fatal error, but it would certainly be
clearer and safer to store $! before calling rmtree.
-- 
David
