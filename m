From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 17:53:40 +0900
Message-ID: <20160607085340.GA21631@glandium.org>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 10:54:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACls-0003Fv-0c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbcFGIx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 04:53:56 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:37998 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbcFGIxy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 04:53:54 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bAClZ-0005e4-0U; Tue, 07 Jun 2016 17:53:41 +0900
Content-Disposition: inline
In-Reply-To: <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296618>

On Tue, Jun 07, 2016 at 10:46:07AM +0200, Christian Couder wrote:
> The high level overview of the patch series I would like to send
> really soon now could go like this:
> 
> ---
> Git can store its objects only in the form of loose objects in
> separate files or packed objects in a pack file.
> To be able to better handle some kind of objects, for example big
> blobs, it would be nice if Git could store its objects in other object
> databases (ODB).
> 
> To do that, this patch series makes it possible to register commands,
> using "odb.<odbname>.command" config variables, to access external
> ODBs. Each specified command will then be called the following ways:
> 
>   - "<command> have": the command should output the sha1, size and
> type of all the objects the external ODB contains, one object per
> line.
>   - "<command> get <sha1>": the command should then read from the
> external ODB the content of the object corresponding to <sha1> and
> output it on stdout.
>   - "<command> put <sha1> <size> <type>": the command should then read
> from stdin an object and store it in the external ODB.

(disclaimer: I didn't look at the patch series)

Does this mean you're going to fork/exec() a new <command> for each of
these? It would probably be better if it was "batched", where the
executable is invoked once and the commands are passed to its stdin.

Mike
