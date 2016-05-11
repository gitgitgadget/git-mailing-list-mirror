From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 3/3] submodule: ensure that -c http.extraheader is
 heeded
Date: Wed, 11 May 2016 08:57:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605110856100.4092@virtualbox>
References: <cover.1462774709.git.johannes.schindelin@gmx.de> <cover.1462863934.git.johannes.schindelin@gmx.de> <1b3d7bde2b92da7722ae46a2f76ccedf532ce35e.1462863934.git.johannes.schindelin@gmx.de> <xmqqzirxq0ec.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 08:57:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0O5H-0005jY-4r
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 08:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbcEKG5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 02:57:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:62421 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbcEKG5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 02:57:22 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFdDB-1aoZim22sf-00Ec0J; Wed, 11 May 2016 08:57:05
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqzirxq0ec.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:R0T6ifaFnbZQV1uxqQmMEGCUPunw5C956EXRTdOoCarROqq+gNl
 gmBkSwcSDqBj+kOE78CimFqIFnhYXkMZLjYDAkCVlrIKEyrSBap4UAhsiMYrtWkiEdGUS2A
 A0mBUXT+PWZ8deILEa058XAEPb4ozhLNH3RYO74fYT4N2g7gpBrKleQYvyh23mqHNG/PJDA
 PsNuZ2m40wJRS+lLfLHxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/tedbG3ZMOc=:Ab3pCfDMDdFjNSdmvPBAPu
 a/5oI8EfvmxRpf2LojBqkiGcgUg64U3z3cdPMPX+KnWNcmJKKfZiImcWFG5i0ngMeFccTJKDF
 HLsAscTZhIWOzhAQs3a3qbqMUkiIM2MQnNh0F4+Z4p9AUTgfNnzRrwTG0r9vVFQCqjc7WVlP7
 66CdVepcuUnoDR0+OSk5e1QfWO/ALnhuhXmueClCT39fDY4XhAz9MjzJbOebJlQaLOFp0Vd6W
 E+qWd96p3S00hYjUcqG0eu+s3bjNVnlIyypVfVrlmaclCoqsQhWhuhvY3dWAWTjHTyG9BM54Z
 yrwKsvoMRX1dqr1sLZh7ppIG3C6IS31R1wxH/wQEmT+ymoSp6BMtqhM0zCIukzm/8IG/qVgtW
 v4FfPNG9H2xbHgcDS8YYG+jhQTJ6pRzIiVuv7T9gkJs2eH6QoT0hAfHR1zCSNfcW0EGLcX0pj
 gcjjzRLuwXum9/I1LLn0R1WU/Dk5aXkvOTqVwdreVPIs9oAEIm/jOL4szGogeLCaxkzAkxiOA
 jMZxjawnzts515LDvHOhsU31jQi82rPpW1xCDUxrDUwNbKTO/lGPHe7GW3UO33DDBJmEpDq2n
 0GuWx0pSHDnGk3jRnEBa1dzwmz+B3Kfu0eEOzoNBXnHteXY/k/UPKoQ/xcJ1QN15R84Bn1QGu
 aHgO2LHLOVsKJoiTu+iLo0ixIQkkgppj5MvPzCKhBUpRw9ZGF9aCGm3zwqxQfcJ0Fk2eusm27
 AHGBOCOrd3wljBqjfuPz0zO3Qcu4cRaBKV/Hb2ZpOm23T9vhD+dHAckGe+BbwfWzjONqRp7M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294232>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > To support this developer's use case of allowing build agents token-based
> > access to private repositories, we introduced the http.extraheader
> > feature, allowing extra HTTP headers to be sent along with every HTTP
> > request.
> >
> > This patch verifies that we can configure these extra HTTP headers via the
> > command-line for use with `git submodule update`, too. Example: git -c
> > http.extraheader="Secret: Sauce" submodule update --init
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Applying this directly on top of the other two fails, and when
> merged with jk/submodule-c-credential, the test passes.
> 
> Which is exactly what we expect to see.  Nice.

Good.

> I'll merge jk/submodule-c-credential into js/http-custom-headers
> that already has 1 & 2, and then apply this.  An alternative would
> be to hold this and wait until both jk/submodule-c-credential and
> js/http-custom-headers with 1 & 2 graduates and then apply this,
> which is a lot inferior option.

As long as it ends up in 2.9.0, I am happy with whatever path these
patches take ;-)

Thanks,
Dscho
