From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 11:44:20 +0400
Message-ID: <37fcd2780808010044m424f8d8en67a4e50363238e4d@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <200807311257.49108.litvinov2004@gmail.com>
	 <20080731104529.GE7008@dpotapov.dyndns.org>
	 <200808011023.32139.litvinov2004@gmail.com>
	 <7v63qluxsb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOpL3-00057s-SM
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbYHAHoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYHAHoV
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:44:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:9334 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbYHAHoU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:44:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1259405wfd.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J3yglxKSRq9POLDG9sUQSEnMQtaSSmw4jzdZdSNKJzA=;
        b=nMkoxP/r2GRzEt6O9To6/wZ3WW0OOk1LeBqKy8P6AUTjY67Kk5bx0MjV8Zc40OTDKr
         9Oq8WMw2LMnCS2ycoUdyRDzWLN6o0isosw4UXB+I2dhQvQy0iobnel6SaTujfgt+9KiP
         3l0OmdGp9MQGR0LHrV4lODZZy4j6nyJLrQ9t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DA/tu8r8k21u95iLJnTgsZDKhsItSegqWIDO3ColinirllEKh0qG83M+MCBpWOvzU9
         f+Yh5NtrI/oTBrZOSVROhYJcdIF4L0srBQrXseQbgDnfKREklgsHh7epviOvT354Ijy6
         IAbp6ChPCxtgYlt4lWsM9b5BFdgSNVQ5ZFqY0=
Received: by 10.142.174.18 with SMTP id w18mr3612473wfe.325.1217576660093;
        Fri, 01 Aug 2008 00:44:20 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Fri, 1 Aug 2008 00:44:20 -0700 (PDT)
In-Reply-To: <7v63qluxsb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91037>

On Fri, Aug 1, 2008 at 9:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Litvinov <litvinov2004@gmail.com> writes:
>
>> I dont think that disabling convertion is a good way. I really want to convert
>> my files. Possible solution is to pass two file names to git-hash-object: the
>> real file with content and the proposed file name in the working directory.
>> In this case git-hash-object will be able to make correct convertion.
>
> I think the optional parameter to say "pretend the content is from this
> path" makes sense even for (and especially for) hashing --stdin.

git-svn uses git hash-object --stdin-paths, which means that it reads
filenames from the  standard input, so one optional parameter cannot
help here. Also, I am not sure how it can be useful for --stdin, which
does not convert anything (it uses index_pipe, which does not call
convert_to_git).

Dmitry
