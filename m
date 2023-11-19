Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273AB128
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 11:29:50 -0800 (PST)
Received: from [192.168.178.189] ([79.246.82.42]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHX3X-1r9SJf1cNF-00DV36; Sun, 19 Nov 2023 20:29:46 +0100
Message-ID: <5da59ea3-f814-4345-8206-856ae68be1c9@delpeuch.eu>
Date: Sun, 19 Nov 2023 20:29:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-file: add --diff-algorithm option
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
 <653b08fd-2df3-4a7a-8082-fdb809e87784@delpeuch.eu>
 <de04aec0-a195-45da-8951-bb30f2a629a3@gmail.com>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <de04aec0-a195-45da-8951-bb30f2a629a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B/bpAMo0UiOjGCP0KM5A2WhWv1XHMoFVkn9I1fc5PZtpVNSGrcC
 PV1Atn/X8nAb4FXdIu5Q043AuLGRozOA+kiOD8YS5xjdKQCyXF+5rIxQM7abxZUMwGOeNds
 NI7QOiHEgSha3ZNMqzKsthKSJVjMAC9OvoEEIivqotIWiLWvRhnGOXTulgl4VNOy7gmmsHR
 88e2+/H69qFzUERGSkbVw==
UI-OutboundReport: notjunk:1;M01:P0:qdS4YBFlo8g=;diXN3uf4nuihsRfh/seKi6hiqHq
 pqPHyL+OCTkwozajGtamdC/gQ+mkHis2dzPz1bCiPN/60979A6oNwNC6P8Xqn1Fz0HJ7H7mPe
 L/1LdsLXgqgimI2mr4GEvb3VEjqpdUZyzS8/s6fRoj7LNJ86lMla/O/4S076gk0wc9dLJUEpl
 IW+l/g6k+734Tgia1shSc5M/ka7Y5Ub07QJdxpMkoJEmSY7l+lH/aAheN0dYAx8czPoJxiDyp
 ZWqX/OyLCTcXfISqAznGdxeIdWEKc0LLd/kW5IfwkKfZ0zUsoF2bnvV8kD2Ofb54lLniqzWjn
 HlsAmXDEAbNdwijktUi0feoXnEU6wBsrL0j94OZZhmKQ3fkh5hFBpce4SmxAckn9pCIE2+K2X
 PL0ArKvB0mUSMcmT5/dQIVqAHy/1BACePcs+eZKx4asBNTDjKuZgJvalSReQIY3ieAWdwTsr0
 1/2/xc96/pe0GQDmfiz6Qs+ohvINFqco+jHYREfr2FdpzmQohIek2m16JclHkFXCYai4JLQVV
 gUT35PkrB/f5cKD1/vulKIeTgqTF8p7ae8urRhl5PPbRFLGJ6Wj/sLvm5rYUKHGyrwt5I0pOP
 ZvbO9Rn0zR8v4dBS4wbNPlZx+misQ2aqx9sMXXzjH82yOc017Wsfy8uaJgVGDGcs8ep2azGL8
 V7Mn/NW46PVX99Dx2bV4uvymR1S8UDimEkcc4luUmqpAjhmfQNpHgCb+7qZOMQcFEBfV4XKt6
 HhhmQftZIMGDtWe0BRzkPLBt0wm66I2xAO7yOTWIwijT4NYWooG1ulszCf3EDNkxht7J1DaKx
 1ojTGrHXItA8zV+vrUqAPYe4M8lduiQv576c6oI/WjkekEedrJ3JpPg3f0IUlSGrMY1YmhFsb
 w4ZMarTh4Gajk/w==

Hi Phillip,

Thank you so much for taking the time to review this!

On 19/11/2023 17:43, Phillip Wood wrote:
> I cannot comment on this particular use but I think in general calling 
> "git merge-file" from a custom merge driver is perfectly sensible. 
> Have you tested your driver with this patch to see if you get better 
> results with the histogram diff algorithm?

Yes, I can confirm that the results are better in my use case indeed.

> I can see there's an argument for changing the default algorithm of 
> "git merge-file" to match what "ort" uses. I know Elijah found the 
> histogram algorithm gave better results in his testing when he was 
> developing "ort". While it would be a breaking change if on the 
> average the new default gives better conflicts it might be worth it. 
> This patch would mean that someone wanting to use the "myers" 
> algorithm could still do so.

Agreed. I would be happy to submit a follow-up patch to change the 
default. Or would you prefer to have it in the same patch (as a separate 
commit)? I was worried this would make my patch less likely to get merged.

> It would be nice to see some tests for this patch, ideally using a 
> test case that gives different conflicts for "myers" and "histogram". 
> We could add the other options later if there is a demand.

Will do.

> Perhaps we could list the available algorithms here so the user does 
> not have to go searching for them in another man page.

This part is copied from "Documentation/merge-strategies.txt", which 
redirects to the manual for git-diff in the same way. I assume it was 
done so that whenever a new diff algorithm is introduced, it only needs 
documenting in one place. But I agree it is definitely more 
user-friendly to list the algorithms directly. Should I change the 
documentation of merge strategies in the same way?

Best wishes,

Antonin

