From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Confused over packfile and index design
Date: Sat, 9 Apr 2011 10:45:41 -0400
Message-ID: <BANLkTin8SXWC2cUqYvrPJrQWQKgMpRk4bg@mail.gmail.com>
References: <m2d3kw70su.fsf@Spindle.sehlabs.com> <BANLkTikXcvRf1bLJXFOHBcGcN-B0m_xSnw@mail.gmail.com>
 <m28vvj7b0d.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 16:46:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8ZQe-0003fb-8E
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 16:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab1DIOqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 10:46:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49012 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab1DIOqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 10:46:04 -0400
Received: by vxi39 with SMTP id 39so3332837vxi.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 07:46:02 -0700 (PDT)
Received: by 10.52.18.67 with SMTP id u3mr1517626vdd.203.1302360362490; Sat,
 09 Apr 2011 07:46:02 -0700 (PDT)
Received: by 10.52.166.133 with HTTP; Sat, 9 Apr 2011 07:45:41 -0700 (PDT)
In-Reply-To: <m28vvj7b0d.fsf@Spindle.sehlabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171194>

On Sat, Apr 9, 2011 at 10:30, Steven E. Harris <seh@panix.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>> Its meant to tell us how many bytes to malloc() in order to hold the
>> result of the libz inflate() call when the object is being read from
>> the packfile. That way we don't under or over allocate the result
>> buffer.
>
> Does Git always inflate the objects into an in-memory buffer?

Yes.

> As the
> size of these objects can be very large (given the variable-length size
> encoding), is there any provision to inflate the object to a temporary
> file?

Not currently. If you don't have enough memory for the malloc() buffer
of a big object, Git dies with an out of memory error.

-- 
Shawn.
