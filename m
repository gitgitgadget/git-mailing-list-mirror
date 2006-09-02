From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla .git tree
Date: Sat, 2 Sep 2006 10:20:49 -0400
Message-ID: <9e4733910609020720w3633aa0cq5016fb1e223fc4cb@mail.gmail.com>
References: <20060829232007.GC22935@spearce.org>
	 <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	 <20060830031029.GA23967@spearce.org>
	 <Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	 <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
	 <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
	 <20060902011950.GB24234@spearce.org>
	 <7v8xl23oia.fsf@assigned-by-dhcp.cox.net>
	 <20060902043931.GA25146@spearce.org>
	 <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 16:20:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJWMg-0001Ew-4d
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 16:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWIBOUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 10:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWIBOUu
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 10:20:50 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:46038 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751106AbWIBOUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 10:20:49 -0400
Received: by py-out-1112.google.com with SMTP id n25so1767178pyg
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 07:20:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6ZKmwfpuUk6rL2pUVX5THpQxaBrjR+YD0RiDmQGQj2Hq2YamM67E7gEvteSeZwjaiDIysYM4S8NSAzl8bba83zPZfU54dy6D1ieHaJmpl9WBy4ivBQjdc4z5z575ztbC1lx8+ATd4FWCQLjltTLHnRjWdOZwjtdAc0bVU6nS7E=
Received: by 10.65.250.11 with SMTP id c11mr1465569qbs;
        Sat, 02 Sep 2006 07:20:49 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Sat, 2 Sep 2006 07:20:49 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vveo6zfx0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26336>

On 9/2/06, Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
> > Using a 28 byte index entry instead of a 32 byte index entry means
> > the Mozilla historical pack index will only be 52.4 MiB rather than
> > the slightly larger 59.9 MiB.
>
> Yup, that was one consideration.  One small worry is we will be
> placing u64 at 4-byte alignment by using 28-byte entries but I
> think that is Ok.

If you're going to redo the pack formats another big win for the
Mozilla pack is to convert pack internal sha1 references into file
offsets.within the pack. Doing that will take around 30MB off from the
Mozilla pack size. sha1's are not compressible so this is a direct
savings.

This might reduce memory usage too. The index is only needed to get
the initial object from the pack. Since index use is lighter it could
just be open/closed when needed.

You could also introduce a zlib dictionary object into the format and
just leave it empty for now.


-- 
Jon Smirl
jonsmirl@gmail.com

-- 
VGER BF report: U 0.5
