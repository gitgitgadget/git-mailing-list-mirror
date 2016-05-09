From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: /* compiler workaround */ - what was the issue?
Date: Mon, 9 May 2016 15:49:53 -0400
Message-ID: <009801d1aa2b$f89f2530$e9dd6f90$@nexbridge.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net><17E04501C9474282B87758C7998A1F5B@PhilipOakley><xmqqtwic9o88.fsf@gitster.mtv.corp.google.com><CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com><51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley><572CDCFF.9050607@ramsayjones.plus.com><xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com><572CF0D5.6010305@xiplink.com><xmqqinyr2c3d.fsf@gitster.mtv.corp.google.com> <CAGZ79kby0Z1FMUT-w8h=YfRxsmyXaiE2pA_VoJ0g9wn0Mzk2Wg@mail.gmail.com> <9836AC86AA754C27AFD5D87519DF1402@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Marc Branchaud'" <marcnarc@xiplink.com>,
	"'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
	"'Duy Nguyen'" <pclouds@gmail.com>,
	"'Git List'" <git@vger.kernel.org>
To: "'Philip Oakley'" <philipoakley@iee.org>,
	"'Stefan Beller'" <sbeller@google.com>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 21:50:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azrCG-0004YP-QU
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 21:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbcEITuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 15:50:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:48992 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbcEITuQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 15:50:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u49Jnxpt026563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 9 May 2016 15:50:00 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <9836AC86AA754C27AFD5D87519DF1402@PhilipOakley>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDlSvIpG+Of9GRgOJuVtc5cQDj9MwJWa0HIAPsSfG8CBLQthgHZ56IoAsjAwpcC7ujIWgD/NCo5AYnc62MCSBqkBAH7SBUwoOwflLA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294043>

On May 9, 2016 3:40 PM Philip Oakley wrote:
> From: "Stefan Beller" <sbeller@google.com>
> > On Fri, May 6, 2016 at 12:57 PM, Junio C Hamano <gitster@pobox.com>
> wrote:
> >> Marc Branchaud <marcnarc@xiplink.com> writes:
> >>
> >>> On 2016-05-06 02:54 PM, Junio C Hamano wrote:
> >>>>
> >>>> I wonder if can we come up with a short and sweet notation to
> >>>> remind futhre readers that this "initialization" is not
> >>>> initializing but merely squelching warnings from stupid compilers,
> >>>> and agree to use it consistently?
> >>>
> >>> Perhaps
> >>>
> >>>       #define COMPILER_UNINITIALIZED_WARNING_INITIALIZER 0
> >>>
> >>> or, for short-and-sweet
> >>>
> >
> >           /* Here could go a longer explanation than the 4 character
> > define :) */
> >>>       #define CUWI 0
> >>>
> >>> ?
> >>>
> >>> :)
> >>
> >> I get that smiley.
> >>
> >> I was hinting to keep the /* compiler workaround */ comment, but in a
> >> bit shorter form.
> >> --
> 
> For some background, I found $gmane/169098/focus=169104 which covers
> some of the issues (the focused msg is one from Junio). Hannes then notes
> ($gmane/169121) that the current xx = xx; could be seen as possible
> undefined behaviour - perhaps one of those 'no good solution' problems.
> 
> Perhaps a suitable name...
> 
> #define SUPPRESS_COMPILER_UNINITIALIZED_WARNING 0
> /* Use when some in-use compiler is unable to determine if the variable is
> used uninitialized, and no good default value is available */
> 
> Though, where best to put it?

I would suggest this type of approach should be detected in the configure script and added automagically (as best as possible) or as a hint supplied by the platform's own specific configuration files if necessary as a last gasp.

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
